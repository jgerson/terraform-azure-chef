# Configure the Chef provider
provider "chef" {
  server_url = "https://api.chef.io/organizations/ajennings/"

  # You can set up a "Client" within the Chef Server management console.
  client_name  = "terraform"
  key_material = "${file("chef-terraform.pem")}"
}

# Create a Chef Environment
resource "chef_environment" "production" {
  name = "production"
}

# Create a Chef Role
resource "chef_role" "app_server" {
  name = "app_server_ajennings"

  run_list = [
    "recipe[terraform]",
  ]
}
