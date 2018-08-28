resource "azurerm_virtual_machine" "myterraformvm" {
  # ...

  provisioner "chef" {
    attributes_json = <<-EOF
      {
        "key": "value",
        "app": {
          "cluster1": {
            "nodes": [
              "webserver1"
            ]
          }
        }
      }
    EOF

    environment     = "_default"
    run_list        = ["cookbook::recipe"]
    node_name       = "webserver1"
    server_url      = "https://api.chef.io/organizations/ajennings"
    recreate_client = true
    user_name       = "chef-terraform"
    user_key        = "${var.key_material}"
    version         = "12.21.1"
    # If you have a self signed cert on your chef server change this to :verify_none
    ssl_verify_mode = ":verify_none"
  }
}
