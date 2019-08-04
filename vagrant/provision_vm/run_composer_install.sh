#!/bin/sh

#RUN "COMPOSER INSTALL"

#output helpful message (right-aligned to stand out from the noise)
printf '\n%*s' $(tput cols) "RUNNING run_composer_install.sh"

#we will receive custom_project_name in $1
CUSTOM_PROJECT_NAME=$1

cd /var/www/vhosts/$CUSTOM_PROJECT_NAME/laravel

php ../composer.phar install
