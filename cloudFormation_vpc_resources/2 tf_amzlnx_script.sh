#!/bin/bash
yum update
yum install httpd -y
systemctl start httpd
systemctl enable httpd
echo "<h1>Hello World! This is Web Server on Amazon Linux</h1>" > /var/www/html/index.html