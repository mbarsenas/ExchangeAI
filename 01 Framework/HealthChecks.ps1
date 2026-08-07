$ExchangeAIHealthChecks = @(

    @{
        Name     = "Accepted Domains"
        Category = "Mail Flow"
        Severity = "High"
        Script   = "$PSScriptRoot\..\02 Health Checks\Mail Flow\Test-AcceptedDomains.ps1"
    }

    @{
        Name     = "DKIM"
        Category = "Mail Flow"
        Severity = "High"
        Script   = "$PSScriptRoot\..\02 Health Checks\Mail Flow\Test-DKIM.ps1"
    }

    @{
        Name     = "SPF"
        Category = "Mail Flow"
        Severity = "High"
        Script   = "$PSScriptRoot\..\02 Health Checks\Mail Flow\Test-SPF.ps1"
    }

    @{
        Name     = "DMARC"
        Category = "Mail Flow"
        Severity = "High"
        Script   = "$PSScriptRoot\..\02 Health Checks\Mail Flow\Test-DMARC.ps1"
    }

    @{
        Name     = "SMTP AUTH"
        Category = "Security"
        Severity = "Medium"
        Script   = "$PSScriptRoot\..\02 Health Checks\Security\Test-SMTPAuth.ps1"
    }

    @{
        Name     = "External Forwarding"
        Category = "Security"
        Severity = "High"
        Script   = "$PSScriptRoot\..\02 Health Checks\Security\Test-ExternalForwarding.ps1"
    }

)