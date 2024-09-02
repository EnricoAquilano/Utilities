# This scripts updates single value or more on one or more azure function

# Define variables
$resourceGroupName  =   "ResourceGroupName"
$prefix             =   ""

# Login to Azure
# Connect-AzAccount -Subscription "SubscriptionId"

# Get all Function Apps in the resource group
$functionApps = Get-AzFunctionApp -ResourceGroupName $resourceGroupName

# Filter Function Apps that start with the specified prefix
$filteredFunctionApps = $functionApps | Where-Object { $_.Name -like "$prefix*" }

foreach ($function in $filteredFunctionApps) {
    # Stop one by one any function
    Stop-AzFunctionApp -ResourceGroupName $resourceGroupName -Name $function.Name -Force
}