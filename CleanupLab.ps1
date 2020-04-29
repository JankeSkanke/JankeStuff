Break
Install-Module MSOnline

$Msolcred = Get-credential
Connect-MsolService -Credential $MsolCred

$domain = Get-msoldomain
Set-MsolDirSyncEnabled -EnableDirSync $false -Force
Get-MsolUser | Where-Object -Property UserPrincipalName -match "demodummies.com"
#Stopp her om denne er blank for da er ikke domenet assignet

Get-MsolUser | Where-Object -Property UserPrincipalName -match "demodummies.com"| Remove-MsolUser -force
Set-MsolDomain -Name $domain.name[0] -IsDefault
Remove-MsolDomain -DomainName $domain.name[1] -force

#
