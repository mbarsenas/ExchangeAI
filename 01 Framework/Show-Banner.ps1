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
        Write-Host "                         $($Config.Name)" -ForegroundColor Cyan
        Write-Host "              $($Config.Description)" -ForegroundColor Cyan
        Write-Host "============================================================" -ForegroundColor Cyan
    }

    Write-Host ""
    Write-Host "Version : $($Config.Version)" -ForegroundColor DarkGray
    Write-Host ""
}