#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#package "nginx" do
#  action :install
#end
#
#service "nginx" do
#  supports :status => true , :restart => true , :reload => true
#  action [ :enable , :start ]
#end
#
#template "nginx.conf" do
#  path "/etc/nginx/nginx.conf"
#  source "nginx.conf.erb"
#  owner "root"
#  group "root"
#  mode 0644
#  notifies :reload,'service[nginx]'
#end

bash "install_nginx" do
  user "root"
  group "root"
  cwd "/tmp"
  flags "-e"
  code <<-EOH
    rm -rf nginx-1.5.6.tar.gz
    rm -rf nginx-1.5.6
    rm -rf pcre-8.32.tar.gz
    rm -rf pcre-8.32
    wget http://nginx.org/download/nginx-1.5.6.tar.gz
    tar zxf nginx-1.5.6.tar.gz
    wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.32.tar.gz
    tar -xvf pcre-8.32.tar.gz
    cd nginx-1.5.6
    ./configure --prefix=/usr/local --conf-path=/etc/nginx/nginx.conf --user=nginx --group=nginx --with-pcre=/tmp/pcre-8.32 --with-http_gzip_static_module
    make
    make install
    chkconfig nginx on
  EOH
  creates "/usr/local/sbin/nginx"
end

directory '/etc/nginx' do
  mode 0755
  owner 'root'
  group 'root'
  recursive true
end

template '/etc/nginx/nginx.conf' do
  source 'nginx.conf.erb'
end

directory '/var/log/nginx' do
  mode 0755
  owner 'root'
  group 'root'
  recursive true
end
