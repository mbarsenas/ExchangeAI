# TenantIQ

TenantIQ is a PowerShell-based Microsoft 365 assessment platform designed to evaluate tenant configuration, identify health and security issues, and generate professional assessment reports.

## Current Version

**v0.3.0**

## Current Module

### Exchange Online

TenantIQ currently includes an Exchange Online assessment engine with health checks for:

- Accepted Domains
- DKIM
- SPF
- DMARC
- Transport Rules
- Connectors
- Remote Domains
- SMTP AUTH
- External Forwarding
- Mailbox Auditing
- Authentication Policies

## Features

- Microsoft 365 tenant assessment framework
- Overall health scoring
- Category scoring
- Executive summary
- Priority findings
- Centralized logging
- Error handling
- Assessment history
- HTML reports
- CSV export
- Print / Export PDF
- Configurable health check registry

## Requirements

- Windows PowerShell or PowerShell 7
- ExchangeOnlineManagement module
- Exchange Online administrative permissions

## Getting Started

Connect to Exchange Online:

```powershell
Connect-ExchangeOnline