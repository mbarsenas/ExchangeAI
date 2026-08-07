$Report = Get-OrganizationConfig |
Select-Object Name,
OAuth2ClientProfileEnabled,
PublicFoldersEnabled

$Report | Format-List

$Report | Export-Csv ".\OrganizationConfigReport.csv" -NoTypeInformation