#Install the Intune Graph Powershell Module
Install-Module Microsoft.Graph.Intune
#Import Module 
Import-Module Microsoft.Graph.Intune
Import-Module AzureAD
#List all options for module 
Get-Command -Module Microsoft.Graph.Intune
(Get-Command -Module Microsoft.Graph.Intune).Count
#Connect to Intune with Consent 
Connect-MSGraph -AdminConsent
Connect-AzureAD 
#
# 
#
# Create a POC Group in AAD
New-AzureADGroup -DisplayName "Intune POC Users" -MailEnabled $false -MailNickName "IntunePOCUsers" -SecurityEnabled $true  -Description "Intune POC Users" 
# Search the AAD Group
$AADGroupId = (Get-AADGroup -Filter "displayName eq 'Intune POC Users'").id

# Create a new iOS Compliance Policy 
$iOSCompliancePolicy = New-IntuneDeviceCompliancePolicy `
    -iosCompliancePolicy `
    -displayName "Hatteland - iOS Compliance Policy" `
    -passcodeRequired $true `
    -passcodeMinimumLength 6 `
    -passcodeMinutesOfInactivityBeforeLock 15 `
    -securityBlockJailbrokenDevices $true `
    -scheduledActionsForRule `
    -osMinimumVersion "12.0"
        (New-DeviceComplianceScheduledActionForRuleObject -ruleName PasswordRequired `
            -scheduledActionConfigurations `
                (New-DeviceComplianceActionItemObject -gracePeriodHours 0 `
                -actionType block `
                -notificationTemplateId "" `
                )`
        )


# Assign the newly created compliance policy to the AAD Group
Invoke-IntuneDeviceCompliancePolicyAssign  -deviceCompliancePolicyId $iOSCompliancePolicy.id `
    -assignments `
        (New-DeviceCompliancePolicyAssignmentObject `
            -target `
                (New-DeviceAndAppManagementAssignmentTargetObject `
                    -groupAssignmentTarget `
                    -groupId "$AADGroupId" `
                ) `
        )