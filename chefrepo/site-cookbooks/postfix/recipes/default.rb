#
# Cookbook Name:: postfix
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "postfix" do
  action :install
end

service "postfix" do
  supports :status => true , :restart => true , :reload => true
  action [ :enable , :start ]
end

template "main.cf" do
  path "/etc/postfix/main.cf"
  source "main.cf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :reload,'service[postfix]'
end

