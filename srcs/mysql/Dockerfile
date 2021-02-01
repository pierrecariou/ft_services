FROM alpine:3.7
MAINTAINER pierrecariou <pierrecariou@outlook.fr>
RUN apk update

# build mysql
RUN apk add mysql mysql-client
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql
RUN apk add openrc --no-cache
RUN rc default
VOLUME ["/sys/fs/cgroup"]

ADD srcs/my.cnf /etc/mysql/
ADD srcs/wordpress.sql /

RUN apk add telegraf --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community
RUN mkdir /etc/telegraf
ADD srcs/telegraf.conf /etc/telegraf/

ADD srcs/script.sh /usr/bin/script.sh
CMD ["/bin/ash", "/usr/bin/script.sh"]
