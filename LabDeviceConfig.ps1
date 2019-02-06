# Verify AzureAD Module
Get-InstalledModule
# Install AzureAD Module
Install-Module AzureAD
#
#
# Go to your resources folder C:\Resources 
#
# Here you should have "Chrome ADMX Ingestion.json" and "Chrome Configuration.json"
#
# To import this settings run DeviceConfiguration_Import_FromJSON.ps1 and point to these two configuration files

./DeviceConfiguration_Import_FromJSON.ps1 

#