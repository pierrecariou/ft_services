FROM alpine:3.7
MAINTAINER pierrecariou <pierrecariou@outlook.fr>
RUN apk update

RUN apk add wget php7 php7-fpm php7-opcache php7-gd php7-mysqli php7-curl php7-mbstring php7-json php7-session

RUN wget http://wordpress.org/latest.tar.gz
RUN tar -xzvf latest.tar.gz
#RUN mv wordpress/* /usr/share/webapps/
RUN rm latest.tar.gz
RUN mkdir /www
RUN mv wordpress/* /www
ADD srcs/wp-config.php /www

RUN apk add nginx
RUN adduser -D -g 'www' user42
RUN chown -R user42:user42 /var/lib/nginx
RUN chown -R user42:user42 www
RUN mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig
ADD srcs/nginx.conf /etc/nginx/nginx.conf
RUN apk add openrc --no-cache
RUN cd run;mkdir nginx;touch nginx/nginx.pid

ADD srcs/script.sh /usr/bin/script.sh
CMD ["/bin/ash", "/usr/bin/script.sh"]
