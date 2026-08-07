function Invoke-HealthCheck {

    param(
        [string]$Name,
        [scriptblock]$Script
    )

    Write-Host ""
    Write-Host "Running $Name..." -ForegroundColor Cyan

    & $Script
}