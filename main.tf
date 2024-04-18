terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.34.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_public_ip" "vm" {
  count               = var.use_public_ip ? 1 : 0
  resource_group_name = var.resource_group_name
  name                = "pip-${var.vm_name}"
  location            = var.location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "example" {
  name                = "nic-${var.vm_name}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip_address != null ? "Static" : "Dynamic"
    private_ip_address            = var.private_ip_address
    private_ip_address_version    = "IPv4"
    public_ip_address_id          = azurerm_public_ip.vm.id
  }
}

resource "azurerm_windows_virtual_machine" "example" {
  name                = "vm-${var.vm_name}"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_sku
  computer_name       = var.vm_name
  admin_username      = var.vm_username
  admin_password      = var.vm_password
  network_interface_ids = [
    azurerm_network_interface.example.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }
}