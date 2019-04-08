resource "azurerm_template_deployment" "infoblox" {
  name                = "infoblox_appliance"
  resource_group_name = "${var.resource_group_name}"
  deployment_mode     = "Incremental"
  template_body       = "${file("${path.module}/templates/infoblox.json")}"

  parameters {
    location                     = "${var.location}"
    vmName                       = "${var.vmName}"
    vmSize                       = "${var.vmSize}"
    niosModel                    = "${var.niosModel}"
    niosVersion                  = "${var.niosVersion}"
    adminPassword                = "${var.adminPassword}"
    virtualNetworkName           = "${var.virtualNetworkName}"
    virtualNetworkExistingRGName = "${var.virtualNetworkExistingRGName}"
    virtualNetworkAddressPrefix  = "${var.virtualNetworkAddressPrefix}"
    subnet1Name                  = "${var.subnet1Name}"
    subnet1Prefix                = "${var.subnet1Prefix}"
    subnet1StartAddress          = "${var.subnet1StartAddress}"
    subnet2Name                  = "${var.subnet2Name}"
    subnet2Prefix                = "${var.subnet2Prefix}"
    subnet2StartAddress          = "${var.subnet2StartAddress}"
    storageAccountName           = "${var.storageAccountName}"

    # storageAccountRG             = "${var.storageAccountRG}"
    storageAccountLogsName = "${var.storageAccountLogsName}"

    # storageAccountLogsRG         = "${var.storageAccountLogsRG}"
    tempLicenseOption = "${var.tempLicenseOption}"
  }
}
