FROM alpine:3.7
MAINTAINER pierrecariou <pierrecariou@outlook.fr>
RUN apk update

RUN apk add wget php7 php7-fpm php7-opcache php7-gd php7-mysqli php7-curl php7-mbstring php7-json php7-session

#Build phpmyadmin
RUN mkdir /www
RUN wget http://files.directadmin.com/services/all/phpMyAdmin/phpMyAdmin-5.0.2-all-languages.tar.gz
RUN tar zxvf phpMyAdmin-5.0.2-all-languages.tar.gz
RUN rm phpMyAdmin-5.0.2-all-languages.tar.gz
RUN mv phpMyAdmin-5.0.2-all-languages/* /www
RUN chmod -R 777 /www
ADD srcs/config.inc.php /www

RUN apk add nginx
RUN adduser -D -g 'www' user42
RUN chown -R user42:user42 /var/lib/nginx
RUN chown -R user42:user42 www
RUN mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig
ADD srcs/nginx.conf /etc/nginx/nginx.conf
RUN apk add openrc --no-cache
RUN cd /run;mkdir nginx;touch nginx/nginx.pid

RUN apk add telegraf --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community
RUN mkdir /etc/telegraf
ADD srcs/telegraf.conf /etc/telegraf/

ADD srcs/script.sh /usr/bin/script.sh
CMD ["/bin/ash", "/usr/bin/script.sh"]
