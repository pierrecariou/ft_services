#!/usr/bin/env bash

rc-service mariadb start
#mysqladmin -u root password user42
#mysql -u root -p << MYSQL
#CREATE DATABASE wordpress;
#GRANT ALL ON wordpress.* TO 'pcariou'@'localhost' IDENTIFIED BY 'user42' WITH GRANT OPTION;
#FLUSH PRIVILEGES;
#exit
#MYSQL

#create wp db if not already exists
mysql -u root -e 'CREATE DATABASE wordpress;'

#create db admin
mysql -u root -e "CREATE USER 'pcariou'@'%' IDENTIFIED BY 'user42';GRANT ALL PRIVILEGES ON *.* TO 'pcariou'@'%' WITH GRANT OPTION;USE wordpress;FLUSH PRIVILEGES;"


/bin/ash
while true
do
	sleep 1
done
