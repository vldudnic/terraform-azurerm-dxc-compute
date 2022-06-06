variable "resource_group_name" {
  description = "The name of the resource group in which the resources will be created."
  type        = string
  default     = "<%=customOptions.azure_code_site%>-<%=customOptions.azure_aip%>-<%=customOptions.azure_env%>-rg"
}

variable "vm_hostname" {
  description = "Name of the virtual machine."
  type        = string
  default     = "<%=customOptions.azure_type%><%=customOptions.azure_code_site%><%=customOptions.azure_aip%><%=customOptions.azure_type_os%><%=customOptions.azure_env_range%>"
}
