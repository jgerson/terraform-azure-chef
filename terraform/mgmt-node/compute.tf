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
      key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC9YxHC06Sjqmyn9HXhVmgp0U+Y68CCC1Cmpgf2wV5KwW4u+i6c3rzkGSTIpCXj8giYDNGQ3WQ6l/iMSCbx/UQS8/XmvNUbVqmD/u8LXfjvrURV2hPxXlDL6V/aAu2jkTKblTh11cXrpWJs+M0xXl2xkSrA5qxHxaeps/l9A7mbzh9yP60pWQw3Ka6rEuWyVRAJWbQMe0sLYgg1FFEEEihulzHvCUx8PO3g9XhG/15GyYr1CnBMj/ALvj99vmpK8yKQOYAop0n3mObBvkzQOzXSmSh1d3OOcPKEV7OD+DBNsfqTF1Ig0YTeYVD8k9lPllTOnObvVuC7Rj2teS0PQfar jgerson@DESKTOP-AOLJGHO"

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

    environment     = "jgerson_test"
    run_list        = ["recipe[chef_terraform_azure_demo]"]
    node_name       = "chef-terraform"
    server_url      = "https://api.chef.io/organizations/jgerson"
    recreate_client = true
    fetch_chef_certificates = true
    user_name       = "jgerson"
    user_key        = "${var.key_material}"
    version         = "12.21.1"
    # If you have a self signed cert on your chef server change to :verify_none
    ssl_verify_mode = ":verify_none"
}
  tags {
    environment = "Terraform Azure Chef Demo"
  }
}
