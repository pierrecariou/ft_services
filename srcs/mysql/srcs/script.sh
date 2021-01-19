#!/usr/bin/env bash

rc-service mariadb start

#create wp db
mysql -u root -e 'CREATE DATABASE wordpress;'

#create db admin
mysql -u root -e "CREATE USER 'pcariou'@'%' IDENTIFIED BY 'user42';GRANT ALL PRIVILEGES ON *.* TO 'pcariou'@'%' WITH GRANT OPTION;USE wordpress;FLUSH PRIVILEGES;"

#/bin/ash
while true
do
	sleep 1
done
