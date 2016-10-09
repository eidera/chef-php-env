#
# Cookbook Name:: mysql_cookbook
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
# mysql rpm
remote_file "#{Chef::Config[:file_cache_path]}/mysql57-community-release-el7-7.noarch.rpm" do
  source "http://dev.mysql.com/get/mysql57-community-release-el7-7.noarch.rpm"
  not_if "rpm -qa | grep -q '^mysql57'"
  action :create
  notifies :install, "rpm_package[mysql57]", :immediately
end

rpm_package "mysql57" do
  source "#{Chef::Config[:file_cache_path]}/mysql57-community-release-el7-7.noarch.rpm"
  action :nothing
end

package 'mysql-community-server' do
  action :install
end

cookbook_file "/etc/my.cnf" do
  source "my.cnf"
  mode 00644
  owner 'root'
  group 'root'
end

bash 'service_setting' do
  user 'root'
  code <<-EOH
    systemctl restart mysqld.service
    systemctl enable mysqld.service
  EOH
end
