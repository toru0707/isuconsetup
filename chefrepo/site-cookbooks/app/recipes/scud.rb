cron "request_scud" do
  minute "*/1"
  user "cumulo"
  command "cd /opt/talendservicerequestor/current && sh polling_order.sh"
end

directory "/var/log/cumulo/scud/orderservice" do
	mode "0755"
	owner "tomcat7"
	group "tomcat7"
	recursive true
	action :create
end

directory "/var/log/cumulo/scud/shippingreportservice" do
	mode "0755"
	owner "tomcat7"
	group "tomcat7"
	recursive true
	action :create
end
