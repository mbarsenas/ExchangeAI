# ExchangeAI

ExchangeAI is a PowerShell-based Exchange Online assessment engine designed for Microsoft 365 administrators, consultants, and MSPs.

It evaluates Exchange Online configuration, identifies health and security issues, calculates health scores, and generates professional HTML and CSV reports.

## Current Version

**v0.2**

## Features

- Exchange Online health assessment
- Centralized logging
- Error handling
- Overall health scoring
- Category scoring
- Executive summary
- Priority findings
- HTML assessment report
- CSV export
- Print / Export PDF
- Professional console interface

## Current Health Checks

### Mail Flow
- Accepted Domains
- DKIM
- SPF
- DMARC

### Security
- SMTP AUTH
- External Forwarding

## Requirements

- PowerShell
- ExchangeOnlineManagement module
- Exchange Online administrative permissions

## Getting Started

Connect to Exchange Online:

```powershell
Connect-ExchangeOnline