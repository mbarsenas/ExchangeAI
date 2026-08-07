$Report = Get-DistributionGroup -ResultSize Unlimited |
Select-Object DisplayName,
PrimarySmtpAddress,
GroupType,
ManagedBy,
HiddenFromAddressListsEnabled

$Report | Format-Table -AutoSize

$Report | Export-Csv ".\DistributionGroupReport.csv" -NoTypeInformation