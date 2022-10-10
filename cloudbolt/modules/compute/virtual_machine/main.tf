#refer to a subnet
data "azurerm_subnet" "subnet" {
  name                 = split("/", var.subnet_name)[1]
  virtual_network_name = split("/", var.subnet_name)[0]
  resource_group_name  = "sdc3-net-shared-rg"
}

module "linuxservers" {
  source              			= "../../../cores/compute/virtual_machine"
 
  #resource_group_name 			= var.resource_group_name
  resource_group_name 			= "example-virtual-machine-rg1"
  #vm_hostname         			= var.vm_hostname // line can be removed if only one VM module per resource group
  vm_hostname         			= "vd-example_vm1"  
  delete_data_disks_on_termination 	= true
  delete_os_disk_on_termination 	= true
  is_nsg             			= false
  is_windows_image              	= false
  admin_password                	= "ComplxP@ssw0rd!"
  allocation_method             	= "Static"
  public_ip_sku                 	= "Standard"
  public_ip_dns                 	= ["test-pip"]
  nb_public_ip                  	= 0
  vm_os_publisher               	= "Canonical"
  vm_os_offer                   	= "UbuntuServer"
  vm_os_sku                     	= "18.04-LTS"
  #vm_size                       	= var.vm_size
  vm_size                         = "Standard_F2"  
  #vnet_subnet_id      			= "${data.azurerm_subnet.subnet.id}"
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
