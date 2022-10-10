#refer to a subnet
data "azurerm_subnet" "subnet" {
  name                 = split("/", var.subnet_name)[1]
  virtual_network_name = split("/", var.subnet_name)[0]
  resource_group_name  = "sdc3-net-vd-rg"
}

module "linuxservers" {
  source              			= "../../../cores/compute/virtual_machine"
 
  resource_group_name 			= var.resource_group_name
  vm_hostname         			= var.vm_hostname // line can be removed if only one VM module per resource group
  delete_data_disks_on_termination 	= true
  delete_os_disk_on_termination 	= true
  is_nsg             			= false
  is_windows_image              	= false
  admin_password                	= "ComplxP@ssw0rd!"
  allocation_method             	= "Static"
  public_ip_sku                 	= "Standard"
  public_ip_dns                 	= ["test-pip"]
  nb_public_ip                  	= 0
  vm_os_publisher               	= "Ubuntu"
  vm_os_offer                   	= ""
  vm_os_sku                     	= ""
  vm_size                       	= var.vm_size
  vnet_subnet_id      			= "${data.azurerm_subnet.subnet.id}"
  enable_accelerated_networking 	= true
  license_type                  	= ""
  identity_type                 	= "SystemAssigned" // can be empty, SystemAssigned or UserAssigned

  nb_data_disk                     	= 1
  data_disk_size_gb                	= 64
  data_sa_type                     	= "Standard_LRS"

#  extra_disks = [
#    {
#      size = 50
#      name = "extraDisk1"
#    },
#    {
#      size = 200
#      name = "extraDisk2"
#    }
#  ] 
}

output "linux_vm_hostname" {
  value = module.linuxserver.network_interface_private_ip
}
