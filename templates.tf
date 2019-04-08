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
    subnet1Name                  = "${var.subnet1Name}"
    subnet1StartAddress          = "${var.subnet1StartAddress}"
    subnet2Name                  = "${var.subnet2Name}"
    subnet2StartAddress          = "${var.subnet2StartAddress}"
    storageAccountName           = "${var.storageAccountName}"
    storageAccountLogsName       = "${var.storageAccountLogsName}"
    tempLicenseOption            = "${var.tempLicenseOption}"
    publicIPExistingRGName       = "${var.publicIPExistingRGName}"
    publicIPAddressName          = "${var.publicIPAddressName}"
    nsgName                      = "${var.nsgName}"
  }
}
