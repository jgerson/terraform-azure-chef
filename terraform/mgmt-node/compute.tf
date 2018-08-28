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
      key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDd7r0PVvR2AUFX9T0wFBfSTQPaNlkBYSphKsshtDvLGq3USHiWNJPwh7F8xqw/DCJNmYZrdReBroWEUShfF6nE8gQcLI8IJO7FYwW/nPs0/GUs6dZQ2FYCnciwqI2EpXWvqt8DmqjxQy0Rp57XEFNzJFzbb5e9P59mEjBy8a8b+orCTHRnHNTh9KfG3x4k5i3JMBy7OojfKvpE25oA27hxwKvJHrl5y4fHqgBCa4NfoWiHwwz1oRPfNdKBFKOuw2mBOFySB8c5aR/zmlNyUYL4+xDB5uweCwSRY2m1oOeApR9kdSptQzeSuxtxqVTYqf9CAT1TEQrNfSLnRhnMEASf agjennings@Amandas-MacBook-Pro-2.local"

    }
  }
  provisioner "chef" {

     connection {
           type        = "ssh"
           user        = "azureuser"
           private_key = "${var.private_key}"
   
}
   attributes_json = <<-EOF
      {
        "key": "value",
        "app": {
          "cluster1": {
            "nodes": [
              "chef-terraform"
            ]
          }
        }
      }
    EOF

    environment     = "ajennings_test"
    run_list        = ["recipe[chef_terraform_azure_demo]"]
    node_name       = "chef-terraform"
    server_url      = "https://api.chef.io/organizations/ajennings"
    recreate_client = true
    fetch_chef_certificates = true
    user_name       = "ajennings"
    user_key        = "${var.key_material}"
    version         = "12.21.1"
    # If you have a self signed cert on your chef server change this to :verify_none
    ssl_verify_mode = ":verify_none"
}
  tags {
    environment = "Terraform Azure Chef Demo"
  }
}
