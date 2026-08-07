$Domains = Get-AcceptedDomain

$Domains | Format-Table Name,DomainName,DomainType,Default -AutoSize

$Domains | Export-Csv ".\AcceptedDomainsHealth.csv" -NoTypeInformation