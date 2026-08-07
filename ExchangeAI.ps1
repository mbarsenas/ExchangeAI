$FrameworkPath = Join-Path $PSScriptRoot "01 Framework"

Get-ChildItem $FrameworkPath -Filter "*.ps1" | ForEach-Object {
    . $_.FullName
}

Show-Banner

$Tenant = "MSFT"
$Connected = "Connected"
$Version = "0.2"
$HealthChecks = $ExchangeAIHealthChecks.Count
$LastRun = "Never"

Write-Host "Tenant        : " -NoNewline
Write-Host $Tenant -ForegroundColor Cyan

Write-Host "Status        : " -NoNewline
Write-Host $Connected -ForegroundColor Green

Write-Host "Version       : " -NoNewline
Write-Host $Version -ForegroundColor Yellow

Write-Host "Health Checks : " -NoNewline
Write-Host $HealthChecks -ForegroundColor Cyan

Write-Host "Last Run      : " -NoNewline
Write-Host $LastRun -ForegroundColor DarkGray

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
        Write-Host "ExchangeAI v0.2"
        Write-Host "Microsoft 365 Assessment Platform"

    }

    "0" {

        return

    }

    default {

        Write-Host ""
        Write-Host "Invalid selection." -ForegroundColor Red

    }

}