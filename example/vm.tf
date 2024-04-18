resource "azurerm_resource_group" "example" {
  name     = "rg-example"
  location = "norwayeast"
}

resource "azurerm_virtual_network" "example" {
  name = "vnet-example"
  location = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  address_space = [ "10.0.0.0/8" ]
  subnet = [ 
    {
    name = "Default"
    address_prefix = "10.0.0.0/24"
  }]
}

module "vm" {
  source              = "git::https://github.com/fwikestad/terraform-azurerm-windows-vm"
  vm_name             = "test"
  resource_group_name = azurerm_resource_group.vm.name
  location            = var.resource_location
  subnet_id           = azurerm_virtual_network.subnet[Default].id
  vm_password         = "Password"
  use_public_ip       = true
}
