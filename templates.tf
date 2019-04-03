resource "azurerm_template_deployment" "infoblox" {
  name                = "${azurerm_sql_server.sql_server.name}_ads"
  resource_group_name = "${var.resource_group_name}"
  deployment_mode     = "Incremental"
  template_body       = "${file("${path.module}/templates/advanced_data_security.json")}"

  parameters {
    serverName           = "${azurerm_sql_server.sql_server.name}"
    storageName          = "${module.storage_account.name}"
    storageResourceGroup = "${module.storage_account.resource_group_name}"
    location             = "${var.location}"
    emailAddresses       = "${var.notification_email_addresses}"
    emailAdmins          = "${var.email_admins}"
    atpLogsRetentionDays = "${var.atp_logs_retention_days}"
  }

  depends_on = ["azurerm_sql_server.sql_server"]
}
