#!/bin/bash
# Script for installing findsorguk source code
# Daniel Pett, 5th May 2015
# This should be run under sudo user so that all commands execute.

echo 'Starting installation of findsorguk - Good luck!'

cd /var/www/
git clone https://github.com/findsorguk/findsorguk-scripts.git finds.org.uk
echo 'Cloned source code to web site folder'

cd finds.org.uk
git submodule update --init --recursive
echo 'Cloned sub module code into git deployed container.'

mkdir('public_html/images')

# If you want all the images from amazon S3, you will need to sync the images folder. It will take a very long time!
# To do this run a s3cmd sync command.

chmod 777 app/cache/
echo 'Set permissions on cache folders to writable'

chown -R www-data:www-data /var/www/finds.org.uk
echo 'Set ownership to www-data group'

cp app/config/application.ini.template application.ini
cp app/config/webservices.ini.template webservices.ini
cp app/config/config.ini.template config.ini
echo 'Copied configuration files - you need to change variables by hand as many are secret.'

cd /etc/apache2/sites-available/
wget https://raw.githubusercontent.com/findsorguk/vhostsConfigs/master/https-finds.org.uk.conf
a2ensite https-finds.org.uk.conf
service apache2 reload
service apache2 restart
echo 'Site vhost file configured and apache restarted'

echo 'Installing solr cores'
cd /var/solr/
git clone https://github.com/findsorguk/findsorguk-solr.git findsorguk
service tomcat7 restart

# You now have a choice - install an empty db or import a dump file.

echo 'Site ready to configure'
