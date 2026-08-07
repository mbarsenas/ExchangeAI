$Report = Get-TransportRule |
Select-Object Name,
State,
Priority,
Mode

$Report | Format-Table -AutoSize

$Report | Export-Csv ".\TransportRulesReport.csv" -NoTypeInformation