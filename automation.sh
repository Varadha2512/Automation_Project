#!/bin/bash
sudo apt update
sudo apt-get install apache2
sudo service apache2 restart
sudo systemctl status apache2.service
d=$(date +%Y-%m-%d-%H%M%S)
SOURCE="/var/log/apache2/"
sudo tar -cvzpf varadha-httpd-logs-$d.tar $SOURCE
sudo mv varadha-httpd-logs-$d.tar /tmp
aws s3 \
cp /tmp/varadha-httpd-logs-$d.tar \
s3://upgrad-varadharajan/varadha-httpd-logs-$d.tar