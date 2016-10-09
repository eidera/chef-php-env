#
# Cookbook Name:: develop_tools_cookbook
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
packages = %w(zsh git screen unzip fontconfig-devel)
packages.each do |pkg|
  package pkg do
    action :install
  end
end

execute "development_tools" do
  user "root"
  command 'yum -y groupinstall "Development Tools"'
  action :run
end
