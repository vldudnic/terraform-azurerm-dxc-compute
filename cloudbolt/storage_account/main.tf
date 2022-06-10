resource "azurerm_storage_account" "standard-storage" {
  name                = "stdstorage"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

  account_tier              = "Standard"
  account_replication_type  = "${var.standard_replication_type}"
  enable_blob_encryption    = "${var.standard_enable_blob_encryption}"
  enable_https_traffic_only = true

  network_rules {
    ip_rules                   = "${var.firewall_allow_ips}"
    virtual_network_subnet_ids = ["${var.vm_subnet_id}"]
  }
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

  template_body = "${file("${path.module}/storage-containers.json")}"
}
