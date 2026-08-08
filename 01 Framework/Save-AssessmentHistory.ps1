function Save-AssessmentHistory {

    param(
        [Parameter(Mandatory)]
        [int]$OverallHealth,

        [Parameter(Mandatory)]
        [int]$Passed,

        [Parameter(Mandatory)]
        [int]$Warnings,

        [Parameter(Mandatory)]
        [int]$Failed
    )

    try {

        $ExchangeAIRoot = Split-Path $PSScriptRoot -Parent

        $OutputFolder = Join-Path `
            $ExchangeAIRoot `
            "06 Output"

        $HistoryFolder = Join-Path `
            $OutputFolder `
            "AssessmentHistory"

        if (-not (Test-Path $HistoryFolder)) {

            New-Item `
                -Path $HistoryFolder `
                -ItemType Directory `
                -Force |
                Out-Null
        }

        $Config = Get-ExchangeAIConfig

        $History = [PSCustomObject]@{

            LastRun       = (Get-Date).ToString("MM/dd/yyyy hh:mm:ss tt")
            OverallHealth = $OverallHealth
            Passed        = $Passed
            Warnings      = $Warnings
            Failed        = $Failed
            Version       = $Config.Version

        }

        $Json = $History |
            ConvertTo-Json -Depth 5

        $LatestFile = Join-Path `
            $HistoryFolder `
            "Latest.json"

        $Json |
            Set-Content `
                -Path $LatestFile `
                -Encoding UTF8 `
                -Force

        $TimeStamp = Get-Date -Format "yyyyMMdd-HHmmss"

        $ArchiveFile = Join-Path `
            $HistoryFolder `
            "$TimeStamp.json"

        $Json |
            Set-Content `
                -Path $ArchiveFile `
                -Encoding UTF8 `
                -Force

        Write-ExchangeAILog `
            -Message "Assessment history saved to $HistoryFolder." `
            -Level INFO

        Write-Host ""
        Write-Host "Assessment history saved:" -ForegroundColor Green
        Write-Host $LatestFile -ForegroundColor Cyan

        return $LatestFile

    }
    catch {

        $ErrorMessage = $_.Exception.Message

        Write-ExchangeAILog `
            -Message "Assessment history save failed. $ErrorMessage" `
            -Level ERROR

        Write-Host ""
        Write-Host "Assessment history save failed:" -ForegroundColor Red
        Write-Host $ErrorMessage -ForegroundColor Red

        throw
    }
}