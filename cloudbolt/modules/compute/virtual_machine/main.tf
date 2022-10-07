#refer to a subnet
data "azurerm_subnet" "subnet" {
  name                 = split("/", var.subnet_name)[1]
  virtual_network_name = split("/", var.subnet_name)[0]
  resource_group_name  = "sdc3-net-shared-rg"
}

module "windowsservers" {
  source              			= "./cores/compute/virtual_machine"
 
  resource_group_name 			= var.resource_group_name
  vm_hostname         			= var.vm_hostname // line can be removed if only one VM module per resource group
  delete_data_disks_on_termination 	= true
  delete_os_disk_on_termination 	= true
  is_nsg             			= false
  is_windows_image              	= true
  admin_password                	= "ComplxP@ssw0rd!"
  allocation_method             	= "Static"
  public_ip_sku                 	= "Standard"
  public_ip_dns                 	= ["test-pip"]
  nb_public_ip                  	= 0
  vm_os_publisher               	= "MicrosoftWindowsServer"
  vm_os_offer                   	= "WindowsServer"
  vm_os_sku                     	= "2012-R2-Datacenter"
  vm_size                       	= var.vm_size
  vnet_subnet_id      			= "${data.azurerm_subnet.subnet.id}"
  enable_accelerated_networking 	= true
  license_type                  	= "Windows_Client"
  identity_type                 	= "SystemAssigned" // can be empty, SystemAssigned or UserAssigned

  nb_data_disk                     	= 2
  data_disk_size_gb                	= 64
  data_sa_type                     	= "Premium_LRS"

  extra_disks = [
    {
      size = 50
      name = "extraDisk1"
    },
    {
      size = 200
      name = "extraDisk2"
    }
  ] 
}

output "windows_vm_hostname" {
  value = module.windowsservers.network_interface_private_ip
}
