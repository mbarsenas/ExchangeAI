function New-HealthCheckResult {

    param(
        [string]$Check,
        [string]$Category,
        [string]$Status,
        [string]$Severity,
        [string]$Finding,
        [string]$Recommendation
    )

    $Result = [PSCustomObject]@{
        Check          = $Check
        Category       = $Category
        Status         = $Status
        Severity       = $Severity
        Finding        = $Finding
        Recommendation = $Recommendation
        Date           = Get-Date
    }

    $Global:ExchangeAIResults += $Result

    return $Result
}