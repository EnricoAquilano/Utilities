# This scripts updates single value or more on one or more azure function

# Define variables
$resourceGroupName  =   "ResourceGroupName"
$envVarName         =   "CronSchedule"
$envVarValue        =   "0 0 0 1 1 *"
$prefix             =   ""

# Login to Azure
# Connect-AzAccount -Subscription "SubscriptionId"

# Get all Function Apps in the resource group
$functionApps = Get-AzFunctionApp -ResourceGroupName $resourceGroupName

# Filter Function Apps that start with the specified prefix
$filteredFunctionApps = $functionApps | Where-Object { $_.Name -like "$prefix*" }

foreach ($function in $filteredFunctionApps) {
    # Get the current configuration of the Function App
    $functionAppSettings = Get-AzFunctionAppSetting -ResourceGroupName $resourceGroupName -Name $function.Name

    # Modify the current configuration 
    $functionAppSettings[$envVarName] = $envVarValue

    # Update the configuration
    Update-AzFunctionAppSetting -ResourceGroupName $resourceGroupName -Name $function.Name -AppSetting $functionAppSettings -Force
}