# ===============================================
# ExchangeAI Health Check Template
# ===============================================

$Stopwatch = [System.Diagnostics.Stopwatch]::StartNew()

Write-ExchangeAILog `
    -Message "Starting <Health Check Name>"

try {

    # ==================================================
    # Health Check Logic
    # ==================================================



    $Stopwatch.Stop()

    Write-ExchangeAILog `
        -Message "<Health Check Name> completed successfully."

    $null = New-HealthCheckResult `
        -Check "<Health Check Name>" `
        -Category "<Category>" `
        -Status "PASS" `
        -Severity "None" `
        -Finding "<Finding>" `
        -Recommendation "No action required." `
        -Duration $Stopwatch.Elapsed.TotalSeconds

}
catch {

    $Stopwatch.Stop()

    Write-ExchangeAILog `
        -Level ERROR `
        -Message $_.Exception.Message

    $null = New-HealthCheckResult `
        -Check "<Health Check Name>" `
        -Category "<Category>" `
        -Status "FAIL" `
        -Severity "High" `
        -Finding $_.Exception.Message `
        -Recommendation "Review ExchangeAI log." `
        -Duration $Stopwatch.Elapsed.TotalSeconds

}