# Create virtual machine
resource "azurerm_virtual_machine" "myterraformvm" {
  name                  = "myVM"
  location              = "East US"
  resource_group_name   = "${azurerm_resource_group.myterraformgroup.name}"
  network_interface_ids = ["${azurerm_network_interface.myterraformnic.id}"]
  vm_size               = "Standard_D1_v2"

  storage_os_disk {
    name              = "myOsDisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04.0-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = "myvm"
    admin_username = "azureuser"
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/azureuser/.ssh/authorized_keys"
      key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDMlVfLSw1cgoBXt9pUvsmhevU1TmLZCJfR1UK2LJqD9raSbb2n96+1F0q6xqUTA/D9NPSOtIhPx39DSZvBkEd+3CFI2KxrlgeChHe7GBeDWfV8/B5Wwq8hbtDQmqjf8/NtM0yfu8L/9zR0EOiicPlAJmxBWm5wMXYH1y1KUk7qq5sOnWr/lGjKsxoxcKZZiUTIH9lZ6Jr9R4uHz4TwyGgVUpwmRhwT98Wcn01lRF5vc/J2F3pY7ZOMybY8oo5MLEFeLFRHMcHnl3REbkZ1xchvqiGIB27jXxwJ+7W8g7AfSta1PDDixuiehtkQ+UtdMrm5un4wsrxxjDWXgszA7YDV agjennings@Amandas-MBP-2.fios-router.home"
    }
  }

  boot_diagnostics {
    enabled     = "true"
    storage_uri = "${azurerm_storage_account.mystorageaccount.primary_blob_endpoint}"
  }

  tags {
    environment = "Terraform Azure Chef Demo"
  }
}
