

$ClientId = "89d6e3de-985b-4da2-b08c-c0474c4665cf"
$ClientSecret = "D+UQxx1EW9LAgStiB5meOoQihnHmmH1vKreX1SRtcpQ="
$SubscriptionId = "312baddd-ddd0-48fd-812a-c9571f7f86cb"
$TenantId = "229365ac-76e3-4cbb-b87e-729538eb5fb4"

$ClientSecret = ConvertTo-SecureString $clientSecret -AsPlainText -Force
$ClientCredential = New-Object System.Management.Automation.PSCredential($ClientId, $clientSecret)

##################################################
Login-AzAccount -ServicePrincipal -Credential $ClientCredential -Tenant $TenantId -WarningAction SilentlyContinue | Out-Null
Select-AzSubscription -SubscriptionName $subscriptionId | Out-Null
Get-AzMarketplaceTerms -Publisher "infoblox" -Product "infoblox-vnios-te-v1420" -Name "vnios-te-v820" | Set-AzMarketplaceTerms -Accept

$resourceGroup = "AlexLyonInfoblox"
$vmName = "infoxbloxTempVm"
$storageAccountName = "alexlyoninfoblox"

New-AzResourceGroupDeployment -Name infobloxTest `
    -ResourceGroupName $resourceGroup `
    -Mode Incremental `
    -TemplateFile "./templates/infoblox.json" `
    -TemplateParameterFile "./templates/parameters.json"



Remove-AzVM -ResourceGroupName $resourceGroup -Name $vmName -Force
Remove-AzAvailabilitySet -ResourceGroupName $resourceGroup -Name "$vmName-AS" -Force
Remove-AzNetworkInterface -ResourceGroupName $resourceGroup -Name "$vmName-lan" -Force
Remove-AzNetworkInterface -ResourceGroupName $resourceGroup -Name "$vmName-mgmt" -Force
$storageKey = Get-AzStorageAccountKey -ResourceGroupName $resourceGroup -Name $storageAccountName -ErrorAction Stop | Where-Object { $_.KeyName -eq "key1" } | Select-Object -ExpandProperty Value
$storageContext = New-AzStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $storageKey
Get-AzStorageBlob -Container "disks" -Context $storageContext | Where-Object { $_.Name -like 'infoxbloxTempVm*.vhd' } | Remove-AzStorageBlob




################################################# 
az login --service-principal -u $ClientId -p $ClientSecret --tenant $TenantId 
az account set --subscription $SubscriptionId

terraform init -backend-config='./backend/I01.backend.tf'
terraform plan -var-file="./tfvars/I01.tfvars" -out='plan.tfplan'
terraform apply 'plan.tfplan'