FROM alpine:3.7
MAINTAINER pierrecariou <pierrecariou@outlook.fr>
RUN apk update

RUN apk add wget php7 php7-fpm php7-opcache php7-gd php7-mysqli php7-zlib php7-curl php7-mbstring php7-json php7-session

RUN wget http://wordpress.org/latest.tar.gz
RUN tar -xzvf latest.tar.gz
#RUN mv wordpress/* /usr/share/webapps/
RUN rm latest.tar.gz
RUN mkdir -p /usr/share/webapps/var/www
RUN mv wordpress /usr/share/webapps/var/www/
ADD srcs/wp-config.php /usr/share/webapps/var/www/

ADD srcs/script.sh /usr/bin/script.sh
CMD ["/bin/ash", "/usr/bin/script.sh"]
