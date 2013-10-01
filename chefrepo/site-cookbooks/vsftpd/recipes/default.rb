#
# Cookbook Name:: vsftpd
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "vsftpd" do
  action :install
end

service "vsftpd" do
  supports :status => true , :restart => true, :reload => true 
  action [ :enable , :start ]
end

template "vsftpd.conf" do
  path "/etc/vsftpd.conf"
  source "vsftpd.conf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :reload,'service[vsftpd]'
end

