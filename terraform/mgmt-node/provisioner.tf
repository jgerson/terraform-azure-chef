variable "chef_provision" { 
  type                      = "map"
  description               = "Configuration details for chef server"

  default = {
    server_url              = "https://api.chef.io/organizations/ajennings"
    user_name               = "ajennings"
    user_key_path           = "~/.chef/ajennings-chef.pem"
    recreate_client         = true
    }
}
