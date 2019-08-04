#!/bin/sh

#INSTALL COMPOSER FOR PHP

#output helpful message (right-aligned to stand out from the noise)
printf '\n%*s' $(tput cols) "RUNNING install_composer.sh"

#we will receive custom_project_name in $1
CUSTOM_PROJECT_NAME=$1

cd /var/www/vhosts/$CUSTOM_PROJECT_NAME

EXPECTED_SIGNATURE=$(wget -q -O - https://composer.github.io/installer.sig)
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
ACTUAL_SIGNATURE=$(php -r "echo hash_file('SHA384', 'composer-setup.php');")

if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]
then
    >&2 echo 'ERROR: Invalid installer signature'
    rm composer-setup.php
    exit 1
fi

php composer-setup.php --quiet
RESULT=$?
rm composer-setup.php
exit $RESULT
