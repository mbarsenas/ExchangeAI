# Get Mailbox Size Report

## Overview

Retrieves mailbox statistics for all Exchange Online user mailboxes, including display name, primary SMTP address, mailbox size, item count, and last logon time.

---

## Requirements

- ExchangeOnlineManagement PowerShell Module
- Exchange Administrator or Global Administrator role
- PowerShell 7 (recommended)

Install the module if needed:

```powershell
Install-Module ExchangeOnlineManagement -Scope CurrentUser
```

---

## Connect to Exchange Online

```powershell
Connect-ExchangeOnline
```

---

## Script

```powershell
# Retrieve mailbox size report

$Mailboxes = Get-EXOMailbox -ResultSize Unlimited

$Report = foreach ($Mailbox in $Mailboxes) {

    $Stats = Get-EXOMailboxStatistics -Identity $Mailbox.UserPrincipalName

    [PSCustomObject]@{
        DisplayName        = $Mailbox.DisplayName
        PrimarySMTPAddress = $Mailbox.PrimarySmtpAddress
        MailboxSize        = $Stats.TotalItemSize
        ItemCount          = $Stats.ItemCount
        LastLogonTime      = $Stats.LastLogonTime
    }
}

$Report | Sort-Object DisplayName | Format-Table -AutoSize
```

---

## Export to CSV

```powershell
$Report | Export-Csv "$env:USERPROFILE\Desktop\MailboxSizeReport.csv" -NoTypeInformation
```

---

## Example Output

| DisplayName | PrimarySMTPAddress | MailboxSize | ItemCount | LastLogonTime |
|-------------|--------------------|------------|----------:|---------------|
| John Smith | john@contoso.com | 7.9 GB | 48,291 | 08/05/2026 8:31 AM |
| Jane Doe | jane@contoso.com | 2.4 GB | 14,827 | 08/06/2026 7:45 AM |

---

## Common Errors

### Get-EXOMailbox : The term is not recognized

Install the Exchange Online Management module.

```powershell
Install-Module ExchangeOnlineManagement
```

---

### Not Connected

```powershell
Connect-ExchangeOnline
```

---

### Access Denied

Verify your account has one of the following roles:

- Exchange Administrator
- Global Administrator
- Organization Management

---

## Performance Notes

- Suitable for small and medium tenants.
- Large environments (10,000+ mailboxes) may take several minutes.
- Uses the modern REST-based Exchange Online cmdlets.

---

## Related Commands

```powershell
Get-EXOMailbox
Get-EXOMailboxStatistics
Get-MailboxStatistics
Get-Mailbox
```

---

## Microsoft Documentation

https://learn.microsoft.com/powershell/module/exchange/get-exomailbox

https://learn.microsoft.com/powershell/module/exchange/get-exomailboxstatistics

---

## Tags

#ExchangeOnline #PowerShell #Reporting #Mailbox #ExchangeAI