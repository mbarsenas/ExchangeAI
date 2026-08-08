function New-HealthCheckResult {

    param(

        [string]$Check,

        [string]$Category,

        [string]$Status,

        [string]$Severity,

        [string]$Finding,

        [string]$Recommendation,

        [double]$Duration = 0

    )

    $Result = [PSCustomObject]@{

        Check          = $Check
        Category       = $Category
        Status         = $Status
        Severity       = $Severity
        Finding        = $Finding
        Recommendation = $Recommendation
        Duration       = [math]::Round($Duration,2)
        Date           = Get-Date

    }

    $Global:ExchangeAIResults += $Result

    return $Result

}