variable "chef_provision" { 
  type                      = "map"
  description               = "Configuration details for chef server"

  default = {
    server_url              = "https://api.chef.io/organizations/org"
    user_name               = "ajennings"
    user_key_path           = "~/.chef/userkey.pem"
    recreate_client         = true
    }
}
