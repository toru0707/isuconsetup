#
# Cookbook Name:: tomcat7
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "tomcat7" do
  action :install
end

service "tomcat7" do
  supports :status => true , :restart => true 
  action [ :enable , :start ]
end

