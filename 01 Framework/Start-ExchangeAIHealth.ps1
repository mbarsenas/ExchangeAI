function Start-ExchangeAIHealth {

    $Global:ExchangeAIResults = @()

    . "$PSScriptRoot\HealthChecks.ps1"

    Clear-Host

    Write-ExchangeAILog `
        -Message "ExchangeAI health assessment started." `
        -Level INFO

    Write-Host ""
    Write-Host "==========================================================" -ForegroundColor Cyan
    Write-Host "               ExchangeAI Health Assessment" -ForegroundColor Cyan
    Write-Host "==========================================================" -ForegroundColor Cyan

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

        Write-ExchangeAILog `
            -Message "Tenant detected: $Tenant" `
            -Level INFO

    }
    catch {

        $Tenant = "Unknown"

        Write-ExchangeAILog `
            -Message "Unable to determine tenant name. $($_.Exception.Message)" `
            -Level ERROR
    }

    Write-Host ""
    Write-Host "Tenant : $Tenant"
    Write-Host "Date   : $(Get-Date -Format 'MM/dd/yyyy hh:mm:ss tt')"
    Write-Host ""

    $TotalChecks = $ExchangeAIHealthChecks.Count
    $CurrentCheck = 1

    foreach ($Check in $ExchangeAIHealthChecks) {

        Write-Host "----------------------------------------------------------" -ForegroundColor DarkGray
        Write-Host "[$CurrentCheck/$TotalChecks] $($Check.Name)" -ForegroundColor Yellow
        Write-Host "----------------------------------------------------------" -ForegroundColor DarkGray
        Write-Host ""

        Write-ExchangeAILog `
            -Message "Starting health check: $($Check.Name)" `
            -Level INFO

        try {

            & $Check.Script

            Write-ExchangeAILog `
                -Message "Completed health check: $($Check.Name)" `
                -Level INFO

        }
        catch {

            $ErrorMessage = $_.Exception.Message

            Write-ExchangeAILog `
                -Message "Health check failed: $($Check.Name). Error: $ErrorMessage" `
                -Level ERROR

            $null = New-HealthCheckResult `
                -Check $Check.Name `
                -Category $Check.Category `
                -Status "FAIL" `
                -Severity "High" `
                -Finding "The health check failed to execute." `
                -Recommendation "Review the ExchangeAI log for detailed error information."

        }

        $CurrentCheck++
    }

    Write-Host ""
    Write-Host "==========================================================" -ForegroundColor Cyan
    Write-Host "Health Assessment Complete" -ForegroundColor Green
    Write-Host "==========================================================" -ForegroundColor Cyan

    Write-ExchangeAILog `
        -Message "ExchangeAI health assessment completed." `
        -Level INFO

    Show-HealthSummary

    Write-Host ""
    Write-Host "Generating HTML assessment report..." -ForegroundColor Cyan

    try {

        $null = Export-ExchangeAIHtmlReport

        Write-ExchangeAILog `
            -Message "HTML assessment report generated successfully." `
            -Level INFO

    }
    catch {

        Write-ExchangeAILog `
            -Message "HTML report generation failed. $($_.Exception.Message)" `
            -Level ERROR
    }
}