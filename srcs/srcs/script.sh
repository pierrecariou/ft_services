echo "CONNECTION AU SERVEUR..."

if [ $autoindex = on ]
then
	echo -e "autoindex on;\n}" >> /etc/nginx/sites-available/default
else
	echo -e "autoindex off;\n}" >> /etc/nginx/sites-available/default
fi

/etc/init.d/mysql start
mariadb << MYSQL
CREATE DATABASE ft_server;
GRANT ALL ON ft_server.* TO 'pcariou'@'localhost' IDENTIFIED BY 'user42' WITH GRANT OPTION;
FLUSH PRIVILEGES;
exit
MYSQL
/etc/init.d/php7.3-fpm start

echo "VOUS ETES CONNECTE"
nginx -g "daemon off;"
