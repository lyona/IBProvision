terraform {
  backend "azurerm" {}
}

/* module "refdata" {
  source = "git::ssh://git@github.lbg.eu-gb.bluemix.net/POC69-PCE/PC-tf-modules.git?ref=master//refdata"
} */

provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  tenant_id       = "${var.tenant_id}"
  client_id       = "${var.client_id}"
}
