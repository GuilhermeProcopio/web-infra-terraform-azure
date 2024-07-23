resource "azurerm_network_security_group" "vnet-security-group" {
  name                = "example-security-group"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_virtual_network" "vnet" {
  name                = "acme-vnet"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name_prefix
  address_space       = ["10.0.0.0/16"]


  subnet {
    name           = "acme-subnet"
    address_prefix = "10.0.0.0/24"
  }
}

resource "azurerm_network_interface" "acme-nic" {
    count = 2
    name = "acme-vm-nic-${count.index}"
    location = var.resource_group_location
    resource_group_name = var.resource_group_name_prefix

    ip_configuration {
      name = "nic-${}"
    }

}