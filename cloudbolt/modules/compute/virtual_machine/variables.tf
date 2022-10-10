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

variable "vm_hostname" {
  description = "Azure VM hostname"
  type        = string
}

variable "vm_size" {
  description = "Azure VM size"
  type        = string
}

variable "subnet_name" {
  description = "Azure Subnet definition"
  type        = string
}

variable "resource_group_name" {
  description = "Azure Resource Group definition"
  type        = string
}




