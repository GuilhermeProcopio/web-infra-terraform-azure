resource "azurerm_linux_virtual_machine" "acme-vm" {
  count               = 2
  name                = "acme-vm${count.index}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_DS1_V2"
  admin_username      = "acmeadmin"
  network_interface_ids = [
    azurerm_network_interface.acme-nic[count.index].id,
  ]

  admin_ssh_key {
    username   = "acmeadmin"
    public_key = azapi_resource_action.ssh_public_key_gen.output.publicKey

  }

  os_disk {
    name                 = "vm-disk"
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

}