function Get-ExchangeAIConfig {

    $RootPath = Split-Path $PSScriptRoot -Parent
    $ConfigPath = Join-Path $RootPath "TenantIQ.json"

    if (-not (Test-Path $ConfigPath)) {
        throw "TenantIQ configuration file not found: $ConfigPath"
    }

    try {

        $Config = Get-Content `
            -Path $ConfigPath `
            -Raw |
            ConvertFrom-Json

        return $Config

    }
    catch {

        throw "Unable to load TenantIQ configuration. $($_.Exception.Message)"

    }
}