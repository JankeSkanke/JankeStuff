Install-Module MSOnline
Connect-MsolService

$MySKUs = Get-MsolAccountSku
$MyUsers = Get-MsolUser

foreach ($user in $MyUsers){
    if (($User.UserPrincipalName -notlike 'admin@*') -and ($User.IsLicensed -eq 'True')){
        Write-Output "Removing license for user: " $user  
        
        foreach ($skuId in ($User.Licenses).AccountSkuID){
            Write-Output "Removing SKU: " $skuid 
            
            Set-MsolUserLicense -ObjectId $user.ObjectId -RemoveLicenses $skuId
            }
        }
}
