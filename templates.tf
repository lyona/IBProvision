resource "azurerm_template_deployment" "infoblox" {
  name                = "infoblox_appliance"
  resource_group_name = "${var.resource_group_name}"
  deployment_mode     = "Incremental"
  template_body       = "${file("${path.module}/templates/infoblox.json")}"

  parameters {
    location                     = "${azurerm_sql_server.sql_server.name}"
    vmName                       = "${module.storage_account.name}"
    vmSize                       = "${module.storage_account.resource_group_name}"
    niosModel                    = "${var.location}"
    niosVersion                  = "${var.notification_email_addresses}"
    adminPassword                = "adminPassword1"
    virtualNetworkName           = "infobloxvnet"
    virtualNetworkExistingRGName = "AlexLyonInfoblox"
    virtualNetworkAddressPrefix  = "10.1.0.0/16"
    subnet1Name                  = "lan1"
    subnet1Prefix                = "10.1.0.0/24"
    subnet1StartAddress          = "10.1.0.4"
    subnet2Name                  = "mgmt"
    subnet2Prefix                = "10.1.1.0/24"
    subnet2StartAddress          = "10.1.1.4"
    storageAccountName           = "alexlyoninfoblox"
    storageAccountRG             = "AlexLyonInfoblox"
    storageAccountLogsName       = "lyonbloxbootdiag"
    storageAccountLogsRG         = "AlexLyonInfoblox"
    tempLicenseOption            = "TE"
  }

  depends_on = ["azurerm_sql_server.sql_server"]
}
