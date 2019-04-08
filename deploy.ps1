

$ClientId = "89d6e3de-985b-4da2-b08c-c0474c4665cf"
$ClientSecret = "D+UQxx1EW9LAgStiB5meOoQihnHmmH1vKreX1SRtcpQ="
$SubscriptionId = "312baddd-ddd0-48fd-812a-c9571f7f86cb"
$TenantId = "229365ac-76e3-4cbb-b87e-729538eb5fb4"

<# $ClientSecret = ConvertTo-SecureString $clientSecret -AsPlainText -Force
$ClientCredential = New-Object System.Management.Automation.PSCredential($ClientId, $clientSecret)

Login-AzAccount -ServicePrincipal -Credential $ClientCredential -Tenant $TenantId -WarningAction SilentlyContinue | Out-Null
Select-AzSubscription -SubscriptionName $subscriptionId | Out-Null

New-AzResourceGroupDeployment -Name infobloxTest -ResourceGroupName "AlexLyonInfoblox" `
    -Mode Incremental -TemplateFile "./templates/infoblox.json" #>

az login --service-principal -u $ClientId -p $ClientSecret --tenant $TenantId 
az account set --subscription $SubscriptionId

terraform init -backend-config='./backend/I01.backend.tf'
terraform plan -var-file="./tfvars/I01.tfvars" -out='plan.tfplan'
terraform apply 'plan.tfplan'