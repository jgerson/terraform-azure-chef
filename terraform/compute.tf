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
      path     = "/Users/agjennings/.ssh/authorized_keys"
      key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDd7r0PVvR2AUFX9T0wFBfSTQPaNlkBYSphKsshtDvLGq3USHiWNJPwh7F8xqw/DCJNmYZrdReBroWEUShfF6nE8gQcLI8IJO7FYwW/nPs0/GUs6dZQ2FYCnciwqI2EpXWvqt8DmqjxQy0Rp57XEFNzJFzbb5e9P59mEjBy8a8b+orCTHRnHNTh9KfG3x4k5i3JMBy7OojfKvpE25oA27hxwKvJHrl5y4fHqgBCa4NfoWiHwwz1oRPfNdKBFKOuw2mBOFySB8c5aR/zmlNyUYL4+xDB5uweCwSRY2m1oOeApR9kdSptQzeSuxtxqVTYqf9CAT1TEQrNfSLnRhnMEASf agjennings@Amandas-MacBook-Pro-2.local"
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
