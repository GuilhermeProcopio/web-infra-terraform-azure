## vm 1

resource "azurerm_linux_virtual_machine" "acme-vm-1" {
  depends_on          = [azurerm_network_interface.acme-nic-1]
  name                = "acme-vm-1"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_DS1_V2"
  network_interface_ids = [
    azurerm_network_interface.acme-nic-1.id,
  ]

  admin_ssh_key {
    username   = var.vm_user
    public_key = azapi_resource_action.ssh_public_key_gen.output.publicKey

  }

  computer_name = "vm-acme-1"

  admin_username = var.vm_user


  os_disk {
    name                 = "vm-disk-1"
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

## vm 2

resource "azurerm_linux_virtual_machine" "acme-vm-2" {
  depends_on          = [azurerm_network_interface.acme-nic-2]
  name                = "acme-vm-2"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_DS1_V2"
  network_interface_ids = [
    azurerm_network_interface.acme-nic-2.id,
  ]

  admin_ssh_key {
    username   = var.vm_user
    public_key = azapi_resource_action.ssh_public_key_gen.output.publicKey

  }

  computer_name = "vm-acme-2"

  admin_username = var.vm_user


  os_disk {
    name                 = "vm-disk-2"
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

# inventário Ansible
resource "local_file" "ansible_inventory" {
  content  = <<EOF
[web]
${azurerm_linux_virtual_machine.acme-vm-1.name} ansible_host=${azurerm_public_ip.public-ip.ip_address} ansible_user=acmeadmin

[db]
${azurerm_linux_virtual_machine.acme-vm-2.name} ansible_host=${azurerm_public_ip.public-ip.ip_address} ansible_user=acmeadmin
EOF
  filename = "inventory.ini"
}