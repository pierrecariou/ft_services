#!/usr/bin/env bash

rc-service mariadb start
#mysqladmin -u root password user42
mysql -u root << MYSQL
CREATE DATABASE wordpress;
GRANT ALL ON wordpress.* TO 'user42'@'localhost' IDENTIFIED BY 'user42' WITH GRANT OPTION;
FLUSH PRIVILEGES;
exit
MYSQL
