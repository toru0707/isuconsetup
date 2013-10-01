include_recipe 'database::mysql'

mysql_connection_info = {:host => "localhost",
                         :username => 'root',
                         :password => node['mysql']['server_root_password']}

mysql_database "virgo" do
  connection mysql_connection_info
  action :create
end

mysql_database_user "virgo" do
  connection mysql_connection_info
  password "password"
  database_name "virgo"
  privileges [:all]
  action [:create, :grant]
end
