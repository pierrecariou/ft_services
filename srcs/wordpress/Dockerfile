FROM alpine:3.7
MAINTAINER pierrecariou <pierrecariou@outlook.fr>
RUN apk update

# build wordpress
RUN apk add php7 php7-fpm php7-opcache php7-gd php7-mysqli php7-zlib php7-curl
RUN apk add wget
RUN wget https://wordpress.org/latest.tar.gz
RUN tar zxvf latest.tar.gz
RUN mkdir /var/www
RUN mkdir /var/www/html
RUN mv wordpress/* /var/www/html/
RUN rm -rf wordpress
#ADD srcs/wp-config.php /var/www/html/
