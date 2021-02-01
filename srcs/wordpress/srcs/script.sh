#!/usr/bin/env bash

php-fpm7
telegraf &
nginx -g 'daemon off;'
#/bin/ash
