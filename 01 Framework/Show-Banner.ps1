function Show-Banner {

    $BannerPath = Join-Path $PSScriptRoot "..\07 Assets\Banner.txt"

    Clear-Host

    if (Test-Path $BannerPath) {
        Get-Content $BannerPath | ForEach-Object {
            Write-Host $_ -ForegroundColor Cyan
        }
    }
    else {
        Write-Host "============================================================" -ForegroundColor Cyan
        Write-Host "                         ExchangeAI" -ForegroundColor Cyan
        Write-Host "              Exchange Online Assessment Engine" -ForegroundColor Cyan
        Write-Host "============================================================" -ForegroundColor Cyan
    }

    Write-Host ""
    Write-Host "Version : 0.2" -ForegroundColor DarkGray
    Write-Host ""
}