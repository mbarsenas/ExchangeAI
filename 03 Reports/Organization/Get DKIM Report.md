$Report = Get-DkimSigningConfig |
Select-Object Domain,
Enabled,
Status

$Report | Format-Table -AutoSize

$Report | Export-Csv ".\DKIMReport.csv" -NoTypeInformation