$Report = Get-EXOMailbox -ResultSize Unlimited |
Select-Object DisplayName,
PrimarySmtpAddress,
ForwardingAddress,
ForwardingSmtpAddress,
DeliverToMailboxAndForward

$Report | Format-Table -AutoSize

$Report | Export-Csv ".\MailboxForwardingReport.csv" -NoTypeInformation