#!/bin/sh

#RUN "NPM INSTALL" (this script can take a while (and / or it hangs waiting for a keyboard input))

#output helpful message (right-aligned to stand out from the noise)
printf '\n%*s' $(tput cols) "RUNNING run_npm_install.sh"

#we will receive custom_project_name in $1
CUSTOM_PROJECT_NAME=$1

# As symlinks (*) blatantly never work (**) in a Linux VM under a Windows host shared folder,
# let's [npm install --no-bin-links] in a non-shared folder then move the resultant stuff back to the Laravel folder.
# *sigh*
# Oh, but we'll still need to install cross-env globally (prob becuase this *does* need to have the bin link)
#
# (*) and, TBH, a couple of other things
# (**) allegedly

cd /home/vagrant
mkdir temporary_npm_install_folder
cd temporary_npm_install_folder

cp /var/www/vhosts/$CUSTOM_PROJECT_NAME/laravel/package.json .
npm install --no-bin-links
# [npm audit fix]?? (there's some kind of goof with the laravel-mix and / or webpack-dev-server package)

# TODO think about if should consider an already existing laravel/node_modules folder
# (prob not on first provisioning)
cp -r node_modules /var/www/vhosts/$CUSTOM_PROJECT_NAME/laravel
cp package-lock.json /var/www/vhosts/$CUSTOM_PROJECT_NAME/laravel

sudo npm install -g cross-env
