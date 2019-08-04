#!/bin/sh

#CONFIGURE DEVELOPMENT ENVIRONMENT GENERALLY

#output helpful message (right-aligned to stand out from the noise)
printf '\n%*s' $(tput cols) "RUNNING kickstart_dev_env.sh"

#we will receive custom_project_name in $1, custom_vm_name in $2, custom_local_domain in $3
CUSTOM_PROJECT_NAME=$1

cd /var/www/vhosts/$CUSTOM_PROJECT_NAME/laravel

#following is for working generally on the app
cp ../vagrant/copy_into/adminer.php public/adminer.php
cp ../vagrant/copy_into/phpinfo.php public/phpinfo.php
