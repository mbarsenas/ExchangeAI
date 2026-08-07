$Report = Get-AcceptedDomain |
Select-Object Name,
DomainName,
DomainType,
Default

$Report | Format-Table -AutoSize

$Report | Export-Csv ".\AcceptedDomainsReport.csv" -NoTypeInformation