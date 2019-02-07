#Connect to Intune Graph 
Import-Module Microsoft.Graph.Intune
Connect-MSGraph 
#Change enviroment to Beta 

$graphApiVersion = "Beta"
Update-MSGraphEnvironment -SchemaVersion $graphApiVersion
$DCompPolicy = Get-IntuneDeviceCompliancePolicy 
foreach($DC in $DCompPolicy){   
    $Name = $DC.displayName
    write-host "Device Compliance Policy:"$Name -f Yellow
    Get-IntuneDeviceCompliancePolicy -deviceCompliancePolicyId $DC.id | ConvertTo-Json | Out-File "C:\IntuneOut\Compliance_$Name.json"
    write-host
}

$DConfPolicy = Get-IntuneDeviceConfigurationPolicy
foreach($ConfP in $DConfPolicy){
    $Name = $ConfP.displayName
    write-host "Device Configuration Policy:"$Name -f Yellow
    Get-IntuneDeviceConfigurationPolicy -deviceConfigurationId $ConfP.id | ConvertTo-Json | Out-File "C:\IntuneOut\Configuration_$Name.json"
    write-host 
}

$APPs = Get-IntuneAppProtectionPolicy 
foreach($APP in $APPs){
    $Name = $APP.displayName
    write-host "Device Configuration Policy:"$Name -f Yellow
    Get-IntuneAppProtectionPolicy -managedAppPolicyId $APP.id | ConvertTo-Json | Out-File "C:\IntuneOut\APP_$Name.json"
    write-host 
}

