function Get-ExchangeAIConfig {

    $RootPath = Split-Path $PSScriptRoot -Parent
    $ConfigPath = Join-Path $RootPath "ExchangeAI.json"

    if (-not (Test-Path $ConfigPath)) {
        throw "ExchangeAI configuration file not found: $ConfigPath"
    }

    try {
        Get-Content $ConfigPath -Raw | ConvertFrom-Json
    }
    catch {
        throw "Unable to load ExchangeAI configuration: $($_.Exception.Message)"
    }
}