variable "subscription_id" {
  description = "Customer Subscription ID"
  default = ""
  type        = string
}

variable "tenant_id" {
  description = "Customer Tenant ID"
  default = ""
  type        = string
}

variable "client_id" {
  description = "Customer Client SPN ID"
  default = ""
  type        = string
}

variable "client_secret" {
  description = "Client SP secret key"
  default = ""
  type        = string
}

variable "resource_group_name" {
  description = "Azure Resource Group definition"
  type        = string
}

variable "location" {
  description = "Azure Resource Group definition"
  type        = string
}

variable "storage_account_name" {
  description = "Azure Storage Account Name"
  type        = string
}

variable "standard_replication_type" {
  description = "Azure Storage Account Replication Type"
  type        = string
}

variable "tls_version" {
  description = "Azure Storage Account TLS version"
  type        = string
}