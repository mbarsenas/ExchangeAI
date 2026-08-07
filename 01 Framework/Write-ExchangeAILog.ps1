function Write-ExchangeAILog {

    param(
        [Parameter(Mandatory)]
        [string]$Message,

        [ValidateSet("INFO","WARNING","ERROR","DEBUG")]
        [string]$Level = "INFO"
    )

    $RootPath = Split-Path $PSScriptRoot -Parent
    $LogPath = Join-Path $RootPath "06 Output\Logs"

    if (-not (Test-Path $LogPath)) {
        New-Item -Path $LogPath -ItemType Directory -Force | Out-Null
    }

    $LogFile = Join-Path $LogPath "ExchangeAI.log"

    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

    $Entry = "[$Timestamp] [$Level] $Message"

    Add-Content `
        -Path $LogFile `
        -Value $Entry `
        -Encoding UTF8

    switch ($Level) {

        "INFO" {
            Write-Host $Entry -ForegroundColor Gray
        }

        "WARNING" {
            Write-Host $Entry -ForegroundColor Yellow
        }

        "ERROR" {
            Write-Host $Entry -ForegroundColor Red
        }

        "DEBUG" {
            Write-Host $Entry -ForegroundColor DarkGray
        }
    }
}