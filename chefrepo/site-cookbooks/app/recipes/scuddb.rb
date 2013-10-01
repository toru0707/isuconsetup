include_recipe 'database::mysql'

mysql_connection_info = {:host => "localhost",
                         :username => 'root',
                         :password => node['mysql']['server_root_password']}

mysql_database "scud" do
  connection mysql_connection_info
  action :create
end

mysql_database_user "scud" do
  connection mysql_connection_info
  password "password"
  database_name "*"
  host '%'
  privileges [:all]
  action [:create, :grant]
end
