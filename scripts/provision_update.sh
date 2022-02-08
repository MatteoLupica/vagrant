#!/bin/bash

echo "Apache2 provisioning - begin"
sudo apt-get install apache2 -y #install apache
sudo a2enmod rewrite #enable mod_rewrite
sudo service apache2 restart #start apache
echo "Apache2 provisioning - end"
