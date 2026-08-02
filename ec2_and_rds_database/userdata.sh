#!/bin/bash
# Enter root access
sudo -s
# Update the os
yum update -y
# Install Apache server
sudo yum install -y httpd
# Install wordpress
sudo amazon-linux-extras install -y php7.2
# Install Wget
yum install wget -y
# Download MySQL Community
wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
# Install MySQL
rpm -ivh mysql-community-release-el7-5.noarch.rpm
# Install MySQL Server
yum install mysql-server
# Install PHP-MySQL
yum install php-mysqlnd -y
# Enter html directory
cd /var/www/html/
# Create html file
echo "healthy" > healthy.html
# Download wordpress
wget https://wordpress.org/latest.tar.gz
# Extract the file
tar -xzf latest.tar.gz
# Coping the wordrpress to html folder
cp -r wordpress/* /var/www/html/
# Remove the folder
rm -rf wordpress
# Remove the file
rm -rf latest.tar.gz
# Give Permisson to the folder
chmod -R 755 wp-content
# Own the file and folders
chown apache:apache /var/www/html
# Check httpd config
chkconfig httpd on  
# Start the httpd service   
service httpd start