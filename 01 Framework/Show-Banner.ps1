function Show-Banner {

    $Config = Get-ExchangeAIConfig

    $RootPath = Split-Path $PSScriptRoot -Parent
    $BannerPath = Join-Path $RootPath "07 Assets\Banner.txt"

    Clear-Host

    if (Test-Path $BannerPath) {

        Get-Content $BannerPath | ForEach-Object {
            Write-Host $_ -ForegroundColor Cyan
        }

    }
    else {
	Write-Host "============================================================" -ForegroundColor Cyan
	Write-Host "                     TenantIQ" -ForegroundColor Cyan
	Write-Host "          Microsoft 365 Assessment Platform" -ForegroundColor Cyan
	Write-Host "============================================================" -ForegroundColor Cyan
    }

    Write-Host ""
    Write-Host "Version : $($Config.Version)" -ForegroundColor DarkGray
    Write-Host ""
}