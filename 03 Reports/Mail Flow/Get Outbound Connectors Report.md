$Report = Get-OutboundConnector |
Select-Object Name,
ConnectorType,
Enabled,
RecipientDomains

$Report | Format-Table -AutoSize

$Report | Export-Csv ".\OutboundConnectorsReport.csv" -NoTypeInformation