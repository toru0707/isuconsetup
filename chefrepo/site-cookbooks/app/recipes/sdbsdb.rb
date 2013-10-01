include_recipe 'database::mysql'

mysql_connection_info = {:host => "localhost",
                         :username => 'root',
                         :password => node['mysql']['server_root_password']}

mysql_database "sdbs_development" do
  connection mysql_connection_info
  action :create
end

mysql_database_user "root" do
  connection mysql_connection_info
  password node['mysql']['server_root_password']
  database_name '*'
  host '%'
  privileges [:all]
  action [:grant]
end

mysql_database_user "sdbs" do
  connection mysql_connection_info
  password "password"
  database_name "sdbs_development"
  host '%'
  privileges [:all]
  action [:create, :grant]
end
