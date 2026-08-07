$Report = Get-RemoteDomain |
Select-Object Name,
DomainName,
AllowedOOFType,
AutoForwardEnabled

$Report | Format-Table -AutoSize

$Report | Export-Csv ".\RemoteDomainsReport.csv" -NoTypeInformation