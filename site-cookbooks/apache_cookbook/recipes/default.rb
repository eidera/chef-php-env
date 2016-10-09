#
# Cookbook Name:: apache_cookbook
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package 'httpd' do
  action :install
end

bash 'service_setting' do
  user 'root'
  code <<-EOH
    systemctl restart httpd.service
    systemctl enable httpd.service
  EOH
end
