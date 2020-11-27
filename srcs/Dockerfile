FROM debian:buster
MAINTAINER pierrecariou <pierrecariou@outlook.fr>
RUN apt update
RUN apt install -y vim


#build LEMP stack

RUN apt install nginx -y
RUN apt install mariadb-server mariadb-client -y
RUN apt install php-fpm php-common php-mbstring php-xmlrpc php-soap php-gd php-xml php-intl php-mysql php-cli php-zip php-curl -y
RUN echo "<?php phpinfo( ); ?>" > /var/www/html/phpinfo.php
ADD srcs/default /etc/nginx/sites-available/


#build wordpress

RUN apt install wget -y
RUN wget https://wordpress.org/latest.tar.gz
RUN tar zxvf latest.tar.gz
#RUN chown -R www-data:www-data /var/www/html/wordpress
RUN mv wordpress/* /var/www/html/
RUN rm -rf wordpress
ADD srcs/wp-config.php /var/www/html/
ENV autoindex on


#build phpmyadmin

RUN wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-english.tar.gz
RUN mkdir /var/www/html/phpmyadmin
RUN tar zxvf phpMyAdmin-4.9.0.1-english.tar.gz --strip-components=1 -C /var/www/html/phpmyadmin
RUN cp /var/www/html/phpmyadmin/config.sample.inc.php /var/www/html/phpmyadmin/config.inc.php
RUN chmod 660 /var/www/html/phpmyadmin/config.inc.php
RUN chown -R www-data:www-data /var/www/html/phpmyadmin


#ssl certificate

RUN mkdir /etc/nginx/ssl
RUN chmod 700 /etc/nginx/ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/localhost.key -out /etc/nginx/ssl/localhost.crt -subj /CN=localhost


#launch script to run

ADD srcs/script.sh /usr/bin/script.sh
CMD ["bash", "script.sh"]

#sudo docker build -t imgbuster .
#sudo docker run --rm -ti -p 80:80 -p 443:443 imgbuster
