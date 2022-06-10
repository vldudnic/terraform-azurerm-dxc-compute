resource "azurerm_storage_account" "standard-storage" {
  name                = "${var.storage_account_name}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

  account_tier              = "Standard"
  account_replication_type  = "${var.standard_replication_type}"
  enable_https_traffic_only = true

}

resource "azurerm_template_deployment" "stdstorage-containers" {
  name                = "stdstorage-containers"
  resource_group_name = "${var.resource_group_name}"
  deployment_mode     = "Incremental"

  depends_on = [
    "azurerm_storage_account.standard-storage"
  ]

  template_body = file("/storage_account/storage-containers.json")
}
