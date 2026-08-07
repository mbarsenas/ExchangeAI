# Get Shared Mailbox Report

## Overview

Retrieves all shared mailboxes in Exchange Online and reports their primary SMTP address, creation date, visibility in the address list, archive status, forwarding configuration, and assigned retention policy.

---

## Requirements

- ExchangeOnlineManagement PowerShell module
- Exchange Administrator role
- Active Exchange Online PowerShell connection

---

## Connect

```powershell
Connect-ExchangeOnline
```

---

## Script

```powershell
$SharedMailboxes = Get-EXOMailbox `
    -RecipientTypeDetails SharedMailbox `
    -ResultSize Unlimited `
    -Properties DisplayName,
                PrimarySmtpAddress,
                WhenCreated,
                HiddenFromAddressListsEnabled,
                ArchiveStatus,
                ForwardingAddress,
                ForwardingSmtpAddress,
                DeliverToMailboxAndForward,
                RetentionPolicy

$Report = foreach ($Mailbox in $SharedMailboxes) {
    [PSCustomObject]@{
        DisplayName                  = $Mailbox.DisplayName
        PrimarySmtpAddress           = $Mailbox.PrimarySmtpAddress
        WhenCreated                  = $Mailbox.WhenCreated
        HiddenFromAddressLists       = $Mailbox.HiddenFromAddressListsEnabled
        ArchiveStatus                = $Mailbox.ArchiveStatus
        ForwardingAddress            = $Mailbox.ForwardingAddress
        ForwardingSmtpAddress        = $Mailbox.ForwardingSmtpAddress
        DeliverToMailboxAndForward   = $Mailbox.DeliverToMailboxAndForward
        RetentionPolicy              = $Mailbox.RetentionPolicy
    }
}

$Report |
    Sort-Object DisplayName |
    Format-Table -AutoSize
```

---

## Export to CSV

```powershell
$ReportPath = Join-Path $env:USERPROFILE "Desktop\SharedMailboxReport.csv"

$Report |
    Sort-Object DisplayName |
    Export-Csv `
        -Path $ReportPath `
        -NoTypeInformation `
        -Encoding UTF8

Write-Host "Report saved to: $ReportPath"
```

---

## Example Output

| DisplayName | PrimarySmtpAddress | ArchiveStatus | HiddenFromAddressLists |
|---|---|---|---|
| Help Desk | helpdesk@contoso.com | None | False |
| Human Resources | hr@contoso.com | Active | False |

---

## Common Errors

### Get-EXOMailbox is not recognized

Install and import the Exchange Online Management module:

```powershell
Install-Module ExchangeOnlineManagement -Scope CurrentUser
Import-Module ExchangeOnlineManagement
```

### Not connected to Exchange Online

```powershell
Connect-ExchangeOnline
```

### No shared mailboxes are returned

Confirm the tenant contains shared mailboxes:

```powershell
Get-Recipient -RecipientTypeDetails SharedMailbox
```

---

## Performance Notes

- Uses one Exchange Online query and should run quickly in most tenants.
- `-ResultSize Unlimited` retrieves every shared mailbox.
- The script is read-only and does not modify tenant configuration.

---

## Related Commands

```powershell
Get-EXOMailbox
Get-MailboxPermission
Get-RecipientPermission
Get-EXOMailboxStatistics
```

---

## Tags

#ExchangeOnline #PowerShell #Reports #SharedMailbox