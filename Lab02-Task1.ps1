# LAB 1 TASK 1 - Commands 

# Assign your given UPN Suffix (given by instructor) 
# (example: aaa.demodummies.com) 

$UPNSuffix = "<INSERT SUFFIX HERE>"
$UPNSuffix2 = "<INSERT SUFFIX HERE>"


# This command will add the suffix to your local AD

Set-ADForest -identity "corp.demodummies.com" -UPNSuffixes @{replace=$UPNSuffix}   

# This command will add the suffix to the users who are in the OUs we are syncing later. 
 
Get-ADUser -Filter * -SearchBase "OU=Users,OU=DemoDummies,DC=corp,DC=demodummies,DC=com" -Properties SamAccountName | ForEach-Object { Set-ADUser $_ -UserPrincipalName ($_.SamAccountName + $UPNSuffix2 )}   

# This command will read the UPN and add this as the Proxy Adress and EMAIL attribute to our users 
# (as we dont have a exchange server in our enviroment) 
# NB This is not a supported way to handle mail attributes in production enviroments

$Users = Get-ADUser -Filter * -SearchBase "OU=Users,OU=DemoDummies,DC=corp,DC=demodummies,DC=com" 

foreach ($user in $Users)
{
	$Proxyaddress = "SMTP:"+$user.userprincipalname
	Set-ADUser $user.samaccountname -replace @{ProxyAddresses=$Proxyaddress}
    Set-ADuser $user.samaccountname -EmailAddress $user.UserPrincipalName
}
