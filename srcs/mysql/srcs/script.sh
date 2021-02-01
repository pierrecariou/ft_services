#!/usr/bin/env bash

#starting mysql
mysql_install_db -u root
rc-service mariadb start

#create wp db
if ! mysql -u root -e 'USE wordpress'
then
	mysql -u root -e 'CREATE DATABASE wordpress;'
	mysql -u root wordpress < /wordpress.sql
fi

#create db admin
mysql -u root -e "CREATE USER 'pcariou'@'%' IDENTIFIED BY 'user42';GRANT ALL PRIVILEGES ON *.* TO 'pcariou'@'%' WITH GRANT OPTION;USE wordpress;FLUSH PRIVILEGES;"

telegraf
