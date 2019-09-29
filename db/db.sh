#!/usr/bin/env bash

# Updating packages
apt-get update

echo "\n----- Installing Apache, Java 8, pip and Unzip ------\n"
apt-get install -y apache2 openjdk-8-jdk
update-alternatives --config java

echo "\n----- MySQL setup ------\n"

# ---------------------------------------
#          MySQL Setup
# ---------------------------------------

# Setting MySQL root user password root/root
debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'


# Installing packages
apt-get install -y mysql-server mysql-client

# Allow External Connections on your MySQL Service
sudo sed -i -e 's/bind-addres/#bind-address/g' /etc/mysql/mysql.conf.d/mysqld.cnf
sudo sed -i -e 's/skip-external-locking/#skip-external-locking/g' /etc/mysql/mysql.conf.d/mysqld.cnf
mysql -u root -proot -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root'; FLUSH privileges;"
sudo service mysql restart
# create client database
mysql -u root -proot -e "CREATE DATABASE mycollab;"
mysql -u root -proot -e "SET GLOBAL time_zone = '+3:00';"

echo "\n----- MyCollab setup ------\n"