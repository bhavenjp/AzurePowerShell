Login-AzureRmAccount
Set-AzureRmContext -SubscriptionName "Free Trial"


$Location = "Southeast Asia"
$RGName = "myWebAppRG"
$Tier = "Free"
$AppsServicePlan = "myWebAppService"
$AppName = "bjpapp"
# $FQDN = "someFQDN.com"


$PropertiesObject = @{
    repoUrl = "https://github.com/bhavenjp/myFirstSite";
    branch = "master";
}


# Create Restoure Group
New-AzureRmResourceGroup -Name $RGName -Location $Location

# Create App Service Plan
New-AzureRmAppServicePlan -Name $AppsServicePlan -Location $Location -ResourceGroupName $RGName -Tier $Tier

# Create Web App
New-AzureRmWebApp -Name $AppName -ResourceGroupName $RGName -Location $Location -AppServicePlan $AppServicePlan 

# Modify Web App property to sync with GitHub
Set-AzureRmResource -PropertyObject $PropertiesObject -ResourceGroupName $RGName -ResourceType Microsoft.Web/sites/sourcecontrols -ResourceName $AppName/web -ApiVersion 2015-08-01 -Force


# Map a registered domain. Ensure that CNAME record is created mapping "$FQDN" to "$AppName.azurewebsites.net"
# Set-AzureRmWebApp -Name $AppName -ResourceGroupName $RGName -HostNames @($FQDN,"$AppName.azurewebsites.net")

