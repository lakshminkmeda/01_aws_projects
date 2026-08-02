#!/bin/bash
apt-get update
apt-get install apache2 -y
systemctl start apache2
systemctl enable apache2
echo "<h1>Hello World! This is Web Server on Ubuntu</h1>" > /var/www/html/index.html