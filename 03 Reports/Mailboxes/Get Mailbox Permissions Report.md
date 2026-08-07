$Report = Get-EXOMailbox -ResultSize Unlimited | ForEach-Object {
    Get-MailboxPermission $_.Identity | Select-Object @{
        Name="Mailbox"
        Expression={$_.Identity}
    },
    User,
    AccessRights,
    IsInherited,
    Deny
}

$Report | Format-Table -AutoSize

$Report | Export-Csv ".\MailboxPermissionsReport.csv" -NoTypeInformation