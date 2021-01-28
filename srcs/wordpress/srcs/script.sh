#!/usr/bin/env bash

#php -S 0.0.0.0:5050 -t usr/share/webapps/var/www/wordpress/
php-fpm7
telegraf &
nginx -g 'daemon off;'
#/bin/ash
