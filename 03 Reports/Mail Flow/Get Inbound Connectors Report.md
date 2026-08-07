$Report = Get-InboundConnector |
Select-Object Name,
ConnectorType,
Enabled,
SenderDomains

$Report | Format-Table -AutoSize

$Report | Export-Csv ".\InboundConnectorsReport.csv" -NoTypeInformation