#!/bin/bash
# Script for installing PAS db
# Daniel Pett, 5th May 2015
cd /var/www/
git clone https://github.com/findsorguk/findsorguk-scripts.git finds.org.uk
git submodule update --init --recursive
cd finds.org.uk
mkdir('public_html/images')
chmod 777 app/cache/
cp app/config/application.ini.template application.ini
cp app/config/webservices.ini.template webservices.ini
cp app/config/config.ini.template config.ini
cd /etc/apache2/sites-available/
wget https://raw.githubusercontent.com/findsorguk/vhostsConfigs/master/https-finds.org.uk.conf
a2ensite https-finds.org.uk.conf
service apache2 reload
service apache2 restart
echo 'Site ready to configure'
