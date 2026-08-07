function New-ExchangeAIReport {
    param(
        [string]$Name,
        [object]$Data,
        [string]$Path = "."
    )

    $FileName = "$Name.csv"
    $FullPath = Join-Path $Path $FileName

    $Data | Export-Csv -Path $FullPath -NoTypeInformation

    Write-Host ""
    Write-Host "Report created: $FullPath" -ForegroundColor Green

    return $FullPath
}