resource "azurerm_storage_account" "standard-storage" {
  name                = "stdstorage"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

  account_tier              = "Standard"
  account_replication_type  = "${var.standard_replication_type}"
  enable_blob_encryption    = "${var.standard_enable_blob_encryption}"
  enable_https_traffic_only = true

}

resource "azurerm_template_deployment" "stdstorage-containers" {
  name                = "stdstorage-containers"
  resource_group_name = "${var.resource_group_name}"
  deployment_mode     = "Incremental"

  depends_on = [
    "azurerm_storage_account.standard-storage",
  ]

  parameters {
    location           = "${var.location}"
    storageAccountName = "${azurerm_storage_account.standard-storage.name}"
  }

  template_url = "https://github.com/pelvis56/terraform-azurerm-dxc-test.git"
  template_body = "${file("storage_account/storage-containers.json")}"
}
