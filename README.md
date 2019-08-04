# vagrant-for-laravel-on-windows

A Vagrant environment for Laravel development. Crucially, it supports the [npm run dev] workflow (though NOTE this might error the first time - just run again and it's fine).

## how to use This

1. Set all of the custom_* variables in the Vagrant file
2. run [vagrant up]
3. That's it!

## uses (AKA "installs")

[] MySQL

[] Nginx

[] Adminer

[] "raw" Laravel Homestead Vagrant image (without the multi-project installer thing)

[] Laravel framework fresh install in 'Laravel' folder (unless that already exists)

[] npm (for Laravel Mix)

[] Composer (and note this is installed as a local .phar in the project root folder)

NOTE Laravel Homestead Vagrant image is Ubuntu and see https://laravel.com/docs/5.8/homestead for the gory details

## TODO

TODO: TLS web vhost support

TODO: optionally - or always? - bundle in Nova? {but this is commercial software}

TODO: support the npm stuff for Nova as well

TODO: option for Postgres

TODO: mention to recommend changing the app's namespace in Vagrant's post_up message
