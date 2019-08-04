#!/bin/sh

#SYSTEM SUPERUSER PROVISIONING

#output helpful message (right-aligned to stand out from the noise)
printf '\n%*s' $(tput cols) "RUNNING root_provisioner.sh"

#we will receive custom_project_name in $1, custom_vm_name in $2, custom_local_domain in $3
CUSTOM_PROJECT_NAME=$1
CUSTOM_VM_NAME=$2
CUSTOM_LOCAL_DOMAIN=$3

#let's get ready for some package related activity!
apt-get update
#apt-get upgrade -y #was slow and prompting interactively

#update global npm packages
npm update -g

#fix the broken(?) laravel/homestead box
#UPDATE nope, this not work here as the broken box won't make it as far as user provisioning
#(please see README.md for the fix)
#apt-get install -y ifupdown

#some Composer packages install via 'git' and '(un)zip' commands
apt-get install -y git zip unzip


#upgrade to PHP 7.2 (from 7.0*) and install requisite extensions
#(php-zip is just for Composer)
#apt-get install -y php
#apt-get install -y php-zip
#apt-get install -y php-xml php7.0-xml
#apt-get install -y php-mysql

#remove PHP 7.0 and install 7.1
#apt-get remove -y php-fpm-7.0
#apt-get install -y --force-yes php-fpm-7.1


#(*) it seems the CLI will update to 7.2 but the webserver is stuck on 7.0 *sigh*
#(hence the need for php7.0-xml as well)

#copy version controlled vhost config into the virtual machine
cp /home/vagrant/$CUSTOM_PROJECT_NAME.vhost.conf /etc/nginx/sites-available/$CUSTOM_PROJECT_NAME.conf
ln -s /etc/nginx/sites-available/$CUSTOM_PROJECT_NAME.conf /etc/nginx/sites-enabled/$CUSTOM_PROJECT_NAME.conf

#sed to replace the template variables in the above nginx config
sed -i.backup "s|CUSTOM[_]LOCAL[_]DOMAIN|$CUSTOM_LOCAL_DOMAIN|g" /etc/nginx/sites-available/$CUSTOM_PROJECT_NAME.conf
sed -i.backup "s|CUSTOM[_]PROJECT[_]NAME|$CUSTOM_PROJECT_NAME|g" /etc/nginx/sites-available/$CUSTOM_PROJECT_NAME.conf


#add needed bits to Apache webserver
#a2enmod ssl
#a2enmod rewrite

#restart Apache webserver
#apache2ctl restart

#not sure of the nitty gritty, but this config file change is needed
#to prevent "bad gateway" type errors from Nginx
#('127.0.0.1:9000' is what we have in our vhost config for nginx)
sed -i.backup "s|listen[ ][=][ ]/run/php/php7[.]3[-]fpm[.]sock|listen = 127.0.0.1:9000|g" /etc/php/7.3/fpm/pool.d/www.conf


#restart php-fpm
service php7.3-fpm restart

#restart nginx
service nginx restart

#create MySQL schema for our app
#(is there a way for Laravel itself (via migrations or what-have-you) to do this?)
mysql -uhomestead -psecret -e "CREATE SCHEMA $CUSTOM_VM_NAME"

#install crontab.txt as root's crontab
cp /var/www/vhosts/$CUSTOM_PROJECT_NAME/vagrant/copy_into/crontab.txt /tmp
sed -i.backup "s|CUSTOM[_]PROJECT[_]NAME|$CUSTOM_PROJECT_NAME|g" /tmp/crontab.txt
crontab /tmp/crontab.txt
