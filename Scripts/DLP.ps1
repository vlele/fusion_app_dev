
#
Install-Module -Name Microsoft.PowerApps.Administration.PowerShel
Install-Module -Name Microsoft.PowerApps.PowerShell -AllowClobber


## Authentication for PowerApps environment
Add-PowerAppsAccount



## Get all environments
$environments = Get-AdminPowerAppEnvironment




## Display all environments to console
$environments | foreach {Write-Host $environments.IndexOf($_) ": " $_.DisplayName}



## Get user selection of environment
$inputEmvironmentValue = Read-Host "Select index of environment: "



## Create new environment specific policy for Default environment
$newPolicy = New-AdminDlpPolicy -DisplayName "Policy-CustomConnector" -EnvironmentName $environments[$inputEmvironmentValue].EnvironmentName



## Get PolicyDetails
Get-AdminDlpPolicy -PolicyName $newPolicy.PolicyName



echo $newPolicy.PolicyName
echo $environments[$inputEmvironmentValue].EnvironmentName



Get-AdminPowerAppConnector > 1.txt




## Adding custom connector
$ConnectorName = ''
$ConnectorId = ''
Add-CustomConnectorToPolicy -PolicyName $newPolicy.PolicyName -ConnectorId $ConnectorId -ConnectorName $ConnectorName -GroupName hbi -ConnectorType "Microsoft.BusinessAppPlatform/scopes/environments/apiPolicies" $environments[$inputEmvironmentValue].EnvironmentName



## Remove the Policy
Remove-AdminDlpPolicy -PolicyName $newPolicy.PolicyName -EnvironmentName $environments[$inputEmvironmentValue].EnvironmentName


