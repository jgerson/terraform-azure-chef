#
# Cookbook:: chef_terraform_azure_demo
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
#

# Install Nginx
execute "apt-get update" do
   command "apt-get update"
 end

 package 'nginx' do
   action :install
 end

 service 'nginx' do
   action [ :enable, :start ]
 end
      
