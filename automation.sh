#!/bin/bash

echo -e "\n\nUpdating Apt Packages and upgrading latest patches\n"
sudo apt-get update -y && sudo apt-get upgrade -y

echo -e "\n\nInstalling Apache2 Web server\n"
sudo apt-get install apache2 -y

echo -e "\n\nRestarting Apache\n"
sudo service apache2 restart

echo -e "\n\nAPACHE2 Installation Completed"
sudo systemctl status apache2

echo "TAR file creation for apache2 logs"
d=$(date +%Y-%m-%d-%H%M%S)
SOURCE="/var/log/apache2/"
sudo tar -cvzpf varadha-httpd-logs-$d.tar $SOURCE
sudo mv varadha-httpd-logs-$d.tar /tmp

echo "Uploading TAR file to AWS S3 bucket"
aws s3 \
cp /tmp/varadha-httpd-logs-$d.tar \
s3://upgrad-varadharajan/varadha-httpd-logs-$d.tar

echo "Cron job content"
cat /etc/cron.d/automation


exit 0
