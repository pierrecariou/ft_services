#!/usr/bin/env bash

telegraf &
/usr/sbin/nginx -g 'daemon off;'
