function Show-HealthSummary {

    $Passed = @(
        $Global:ExchangeAIResults |
        Where-Object { $_.Status -eq "PASS" }
    ).Count

    $Warnings = @(
        $Global:ExchangeAIResults |
        Where-Object { $_.Status -eq "WARNING" }
    ).Count

    $Failed = @(
        $Global:ExchangeAIResults |
        Where-Object { $_.Status -eq "FAIL" }
    ).Count

    $Total = @($Global:ExchangeAIResults).Count

    if ($Total -eq 0) {
        $Score = 0
    }
    else {
        $Score = [math]::Round(($Passed / $Total) * 100)
    }

    if ($Score -ge 90) {
        $ScoreColor = "Green"
    }
    elseif ($Score -ge 70) {
        $ScoreColor = "Yellow"
    }
    else {
        $ScoreColor = "Red"
    }

    Write-Host ""
    Write-Host "==========================================================" -ForegroundColor Cyan
    Write-Host "               ExchangeAI Health Summary" -ForegroundColor Cyan
    Write-Host "==========================================================" -ForegroundColor Cyan
    Write-Host ""

    Write-Host "Checks Completed : $Total"
    Write-Host "Passed           : $Passed" -ForegroundColor Green
    Write-Host "Warnings         : $Warnings" -ForegroundColor Yellow
    Write-Host "Failed           : $Failed" -ForegroundColor Red

    Write-Host ""
    Write-Host "Overall Health   : $Score%" -ForegroundColor $ScoreColor
    Write-Host ""

    $Categories = @(
        $Global:ExchangeAIResults |
        Where-Object {
            -not [string]::IsNullOrWhiteSpace($_.Category)
        } |
        Group-Object Category
    )

    if ($Categories.Count -gt 0) {

        Write-Host "Category Scores" -ForegroundColor Cyan
        Write-Host "---------------"

        foreach ($Category in $Categories) {

            $CategoryPassed = @(
                $Category.Group |
                Where-Object { $_.Status -eq "PASS" }
            ).Count

            $CategoryTotal = $Category.Group.Count

            if ($CategoryTotal -eq 0) {
                $CategoryScore = 0
            }
            else {
                $CategoryScore = [math]::Round(
                    ($CategoryPassed / $CategoryTotal) * 100
                )
            }

            Write-Host "$($Category.Name.PadRight(20)) $CategoryScore%"
        }

        Write-Host ""
    }

    $Failures = @(
        $Global:ExchangeAIResults |
        Where-Object { $_.Status -eq "FAIL" }
    )

    Write-Host "Critical Findings" -ForegroundColor Red
    Write-Host "-----------------"

    if ($Failures.Count -eq 0) {

        Write-Host "None" -ForegroundColor Green
    }
    else {

        foreach ($Result in $Failures) {

            Write-Host ""
            Write-Host "[FAIL] $($Result.Check)" -ForegroundColor Red
            Write-Host "       $($Result.Finding)"
        }
    }

    Write-Host ""

    $WarningResults = @(
        $Global:ExchangeAIResults |
        Where-Object { $_.Status -eq "WARNING" }
    )

    if ($WarningResults.Count -gt 0) {

        Write-Host "Warnings" -ForegroundColor Yellow
        Write-Host "--------"

        foreach ($Result in $WarningResults) {

            Write-Host ""
            Write-Host "[WARN] $($Result.Check)" -ForegroundColor Yellow
            Write-Host "       $($Result.Finding)"
        }

        Write-Host ""
    }

    $Recommendations = @(
        $Global:ExchangeAIResults |
        Where-Object {
            -not [string]::IsNullOrWhiteSpace($_.Recommendation) -and
            $_.Recommendation -ne "No action required."
        }
    )

    Write-Host "Recommendations" -ForegroundColor Cyan
    Write-Host "---------------"

    if ($Recommendations.Count -eq 0) {

        Write-Host "None" -ForegroundColor Green
    }
    else {

        foreach ($Result in $Recommendations) {
            Write-Host "- $($Result.Recommendation)"
        }
    }

    Write-Host ""
    Write-Host "==========================================================" -ForegroundColor Cyan
}