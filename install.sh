cd

echo test
## vim
#sudo yum -y install vim

## tmux
# install deps
# sudo yum -y install gcc kernel-devel make ncurses-devel
# tar xzvf libevent-2.0.21-stable.tar.gz
# cd libevent-2.0.21-stable
# ./configure --prefix=/usr/local
# sudo make 
# sudo make install
# cd 
# tar xzvf tmux-1.8.tar.gz
# cd tmux-1.8
# LDFLAGS="-L/usr/local/lib -Wl,-rpath=/usr/local/lib" ./configure --prefix=/usr/local
# sudo make 
# sudo make install
# cd 

## mysql5.7.2
#wget -O /tmp/mysql5.7.2.tar http://dev.mysql.com/get/Downloads/MySQL-5.7/MySQL-5.7.2-m12-1.linux_glibc2.5.x86_64.rpm-bundle.tar/from/http://cdn.mysql.com/
#cd /tmp
#tar xvf mysql5.7.2.tar
#sudo rpm -ivh MySQL-shared-compat-5.7.2_m12-1.linux_glibc2.5.x86_64.rpm
#sudo rpm -e mysql-libs-5.1.66-2.el6_3.x86_64
#sudo rpm -ivh MySQL-server-5.7.2_m12-1.linux_glibc2.5.x86_64.rpm
#sudo rpm -ivh MySQL-client-5.7.2_m12-1.linux_glibc2.5.x86_64.rpm
## /root/.mysql_secret

## dstat
#wget http://pkgs.repoforge.org/dstat/dstat-0.7.2-1.el6.rfx.noarch.rpm
#sudo rpm -ivh dstat-0.7.2-1.el6.rfx.noarch.rpm

## memcached
#sudo ln -s /usr/local/lib/libevent-2.0.so.5 /usr/lib64/libevent-2.0.so.5
#wget http://memcached.googlecode.com/files/memcached-1.4.15.tar.gz
#tar xzvf memcached-1.4.15.tar.gz
#cd memcached-1.4.15
#./configure
#sudo make
#sudo make install
#
## telnet
#sudo yum -y install telnet

# node 11.4
cd 
git clone https://github.com/joyent/node.git
