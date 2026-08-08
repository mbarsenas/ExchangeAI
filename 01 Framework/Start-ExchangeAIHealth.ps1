function Start-ExchangeAIHealth {

    $Global:ExchangeAIResults = @()

    . "$PSScriptRoot\HealthChecks.ps1"

    Clear-Host

    Write-ExchangeAILog `
        -Message "ExchangeAI health assessment started." `
        -Level INFO

    Write-Host ""
    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host "               ExchangeAI Health Assessment" -ForegroundColor Cyan
    Write-Host "============================================================" -ForegroundColor Cyan

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

    }
    catch {

        $Tenant = "Unknown"

    }

    Write-Host ""
    Write-Host "Tenant : " -NoNewline
    Write-Host $Tenant -ForegroundColor Cyan

    Write-Host "Date   : " -NoNewline
    Write-Host (Get-Date -Format "MM/dd/yyyy hh:mm:ss tt") -ForegroundColor Yellow

    Write-Host ""

    $TotalChecks = $ExchangeAIHealthChecks.Count
    $CurrentCheck = 1

    foreach ($Check in $ExchangeAIHealthChecks) {

        Clear-Host

        $Percent = [math]::Round(($CurrentCheck / $TotalChecks) * 100)

        $Filled = [math]::Floor($Percent / 5)

        $Bar = ("#" * $Filled).PadRight(20, "-")

        Write-Host ""
        Write-Host "============================================================" -ForegroundColor Cyan
        Write-Host "               ExchangeAI Health Assessment" -ForegroundColor Cyan
        Write-Host "============================================================" -ForegroundColor Cyan
        Write-Host ""

        Write-Host "Progress" -ForegroundColor Cyan
        Write-Host "$Bar $Percent%"
        Write-Host ""

        Write-Host "Current Check" -ForegroundColor Cyan
        Write-Host "-------------"
        Write-Host $Check.Name
        Write-Host ""

        Write-Host "Category" -ForegroundColor Cyan
        Write-Host "--------"
        Write-Host $Check.Category
        Write-Host ""

        Write-Host "Severity" -ForegroundColor Cyan
        Write-Host "--------"
        Write-Host $Check.Severity
        Write-Host ""

        Write-Host "Estimated Time" -ForegroundColor Cyan
        Write-Host "--------------"
        Write-Host $Check.EstimatedTime
        Write-Host ""

        Write-Host "Description" -ForegroundColor Cyan
        Write-Host "-----------"
        Write-Host $Check.Description
        Write-Host ""

        Write-ExchangeAILog `
            -Message "Running $($Check.Name)" `
            -Level INFO

        try {

            & $Check.Script

        }
        catch {

            Write-ExchangeAILog `
                -Message $_.Exception.Message `
                -Level ERROR

            $null = New-HealthCheckResult `
                -Check $Check.Name `
                -Category $Check.Category `
                -Status "FAIL" `
                -Severity "High" `
                -Finding $_.Exception.Message `
                -Recommendation "Review ExchangeAI log."

        }

        $CurrentCheck++

    }

    Clear-Host

    Write-Host ""
    Write-Host "============================================================" -ForegroundColor Green
    Write-Host "              ExchangeAI Assessment Complete" -ForegroundColor Green
    Write-Host "============================================================" -ForegroundColor Green

    Show-HealthSummary

    Write-Host ""

    Write-ExchangeAILog `
        -Message "Generating HTML Report." `
        -Level INFO

    Export-ExchangeAIHtmlReport

}