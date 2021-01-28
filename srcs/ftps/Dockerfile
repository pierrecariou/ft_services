FROM alpine:3.7
MAINTAINER pierrecariou <pierrecariou@outlook.fr>
RUN apk update

RUN apk add vsftpd
RUN mv /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.ori
ADD srcs/vsftpd.conf /etc/vsftpd/

RUN apk add openssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/vsftpd.key -out /etc/ssl/certs/vsftpd.crt -subj /CN=192.168.99.148

RUN apk add telegraf --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community
RUN mkdir /etc/telegraf
ADD srcs/telegraf.conf /etc/telegraf/

ADD srcs/script.sh /usr/bin/script.sh
CMD ["/bin/ash", "/usr/bin/script.sh"]
