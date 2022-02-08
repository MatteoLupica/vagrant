#!/bin/bash
ROOTPASSWD='Password&1'
DBNAME=vagrant
DBUSER=vagrant
DBPASSWD=vagrantpass
echo "Creating new db $DBNAME"
mysql -uroot -p$ROOTPASSWD -e "CREATE DATABASE $DBNAME"
sudo mysql -uroot -e "CREATE USER $USER@'%' IDENTIFIED BY '$DBPASSWD'"
sudo mysql -uroot -e "GRANT all privileges on $DBNAME.* to '$DBUSER'@'%' identified by '$DBPASSWD'"
