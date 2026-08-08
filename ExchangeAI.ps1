$FrameworkPath = Join-Path $PSScriptRoot "01 Framework"

Get-ChildItem $FrameworkPath -Filter "*.ps1" | ForEach-Object {
    . $_.FullName
}

$Config = Get-ExchangeAIConfig

. "$FrameworkPath\HealthChecks.ps1"

Show-Banner

try {

    $Org = Get-OrganizationConfig -ErrorAction Stop

    if ([string]::IsNullOrWhiteSpace($Org.DisplayName)) {

        $Tenant = (
            Get-AcceptedDomain |
            Where-Object { $_.Default -eq $true }
        ).DomainName

    }
    else {

        $Tenant = $Org.DisplayName
    }

    $Connected = "[OK] Connected"
    $StatusColor = "Green"

}
catch {

    $Tenant = "Unknown"
    $Connected = "[ERROR] Not Connected"
    $StatusColor = "Red"
}

$HealthChecks = $ExchangeAIHealthChecks.Count

$HistoryPath = Join-Path `
    $PSScriptRoot `
    "06 Output\AssessmentHistory\Latest.json"

if (Test-Path $HistoryPath) {

    try {

        $History = Get-Content `
            -Path $HistoryPath `
            -Raw |
            ConvertFrom-Json

        $LastRun = $History.LastRun
        $LastScore = "$($History.OverallHealth)%"

    }
    catch {

        $LastRun = "Unknown"
        $LastScore = "Unknown"

        Write-ExchangeAILog `
            -Message "Unable to read assessment history. $($_.Exception.Message)" `
            -Level WARNING
    }

}
else {

    $LastRun = "Never"
    $LastScore = "N/A"
}

Write-Host "Tenant        : " -NoNewline
Write-Host $Tenant -ForegroundColor Cyan

Write-Host "Status        : " -NoNewline
Write-Host $Connected -ForegroundColor $StatusColor

Write-Host "Version       : " -NoNewline
Write-Host $Config.Version -ForegroundColor Yellow

Write-Host "Health Checks : " -NoNewline
Write-Host $HealthChecks -ForegroundColor Cyan

Write-Host "Last Run      : " -NoNewline
Write-Host $LastRun -ForegroundColor DarkGray

Write-Host "Last Score    : " -NoNewline

if ($LastScore -eq "N/A" -or $LastScore -eq "Unknown") {

    Write-Host $LastScore -ForegroundColor DarkGray

}
else {

    $ScoreValue = [int](
        $History.OverallHealth
    )

    if ($ScoreValue -ge 90) {
        $ScoreColor = "Green"
    }
    elseif ($ScoreValue -ge 70) {
        $ScoreColor = "Yellow"
    }
    else {
        $ScoreColor = "Red"
    }

    Write-Host $LastScore -ForegroundColor $ScoreColor
}

Write-Host ""
Write-Host "============================================================" -ForegroundColor DarkGray
Write-Host ""

Write-Host "[1] Full Health Assessment"
Write-Host "[2] Health Checks"
Write-Host "[3] Reports"
Write-Host "[4] Settings"
Write-Host "[5] About"
Write-Host "[0] Exit"

Write-Host ""
Write-Host "============================================================" -ForegroundColor DarkGray
Write-Host ""

$Choice = Read-Host "Select"

switch ($Choice) {

    "1" {

        Start-ExchangeAIHealth

    }

    "2" {

        Show-HealthChecksMenu

    }

    "3" {

        Write-Host ""
        Write-Host "Reports coming soon..." -ForegroundColor Yellow

    }

    "4" {

        Write-Host ""
        Write-Host "Settings coming soon..." -ForegroundColor Yellow

    }

    "5" {

        Write-Host ""
        Write-Host "$($Config.Name) v$($Config.Version)"
        Write-Host $Config.Description
        Write-Host ""
        Write-Host "Author     : $($Config.Author)"
        Write-Host "Repository : $($Config.Repository)"

    }

    "0" {

        return

    }

    default {

        Write-Host ""
        Write-Host "Invalid selection." -ForegroundColor Red

    }

}