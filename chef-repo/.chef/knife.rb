# See http://docs.chef.io/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "azure_test"
cookbook_path            ["#{current_dir}/../cookbooks"]
client_key               "/Users/agjennings/terraform-azure-chef/chef-repo/.chef/ajennings.pem"
validation_key           "/non-exist" 
chef_server_url          "https://api.chef.io/organizations/ajennings"
