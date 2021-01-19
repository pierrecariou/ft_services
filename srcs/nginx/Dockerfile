FROM alpine:3.7
MAINTAINER pierrecariou <pierrecariou@outlook.fr>
RUN apk update

RUN apk add nginx
RUN adduser -D -g 'www' user42
RUN mkdir www
RUN chown -R user42:user42 /var/lib/nginx
RUN chown -R user42:user42 www
RUN mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig
ADD srcs/nginx.conf /etc/nginx/nginx.conf
ADD srcs/index.html /www/index.html
RUN apk add openrc --no-cache
RUN cd run;mkdir nginx;touch nginx/nginx.pid

RUN mkdir /etc/nginx/ssl
RUN chmod 700 /etc/nginx/ssl
RUN apk add openssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/localhost.key -out /etc/nginx/ssl/localhost.crt -subj /CN=localhost

ADD srcs/script.sh /usr/bin/script.sh
CMD ["/bin/ash", "/usr/bin/script.sh"]
