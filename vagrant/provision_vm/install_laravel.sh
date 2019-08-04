#!/bin/sh

#INSTALL LARAVEL (but only on first provisioning)

#output helpful message (right-aligned to stand out from the noise)
printf '\n%*s' $(tput cols) "RUNNING install_laravel.sh"

#we will receive custom_project_name in $1
CUSTOM_PROJECT_NAME=$1

cd /var/www/vhosts/$CUSTOM_PROJECT_NAME

#put Laravel in 'laravel' folder (only if that folder does not already exist)
if [ ! -d laravel ]; then
  #laravel new laravel    ##TTY errors with this one
  composer create-project --prefer-dist laravel/laravel laravel
else
  echo "***Not installing Laravel as folder already exists***"
fi
