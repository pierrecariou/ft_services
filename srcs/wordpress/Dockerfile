FROM alpine:3.7
MAINTAINER pierrecariou <pierrecariou@outlook.fr>
RUN apk update

# build wordpress
RUN apk add wget
RUN wget https://wordpress.org/latest.tar.gz
RUN tar zxvf latest.tar.gz
#RUN mv wordpress/* /var/www/html/
#RUN rm -rf wordpress
#ADD srcs/wp-config.php /var/www/html/
