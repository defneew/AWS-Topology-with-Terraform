#!/bin/bash
# Ubuntu için apt ve apache2 kullanıyoruz
apt update -y
apt install -y apache2 # httpd yerine apache2 kuruyoruz
systemctl start apache2 # httpd.service yerine apache2.service kullanıyoruz
systemctl enable apache2 
echo "Hello from EC2 in Private Subnet!" | sudo tee /var/www/html/index.html > /dev/null