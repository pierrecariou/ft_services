FROM alpine:3.7
MAINTAINER pierrecariou <pierrecariou@outlook.fr>
RUN apk update

# build mysql
RUN apk add mysql mysql-client
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql
RUN apk add openrc --no-cache
RUN rc default
VOLUME ["/sys/fs/cgroup"]

#ADD srcs/my.cnf /etc/mysql/

ADD srcs/script.sh /usr/bin/script.sh
CMD ["/bin/ash", "/usr/bin/script.sh"]
