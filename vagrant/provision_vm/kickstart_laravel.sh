#!/bin/sh

#CONFIGURE LARAVEL

#output helpful message (right-aligned to stand out from the noise)
printf '\n%*s' $(tput cols) "RUNNING kickstart_laravel.sh"

#we will receive custom_project_name in $1
CUSTOM_PROJECT_NAME=$1

cd /var/www/vhosts/$CUSTOM_PROJECT_NAME/laravel

#cp .env.development .env

#TODO copy a .env.development (or .env.example) to .env (if it not exist)?? (for if there is already a laravel folder but no Vagrant setup)

#NOTE fresh install o Laravel will create a .env file

#make a .env file to start putting *staging* settings into
#(or should copy from .env.example?)
if [ ! -f .env.staging ]; then
  cp .env .env.staging
fi

#make a .env file to start putting *production* settings into
#(or should copy from .env.example?)
if [ ! -f .env.production ]; then
  cp .env .env.production
fi


#TODO could put [artisan migrate] commands etc here
