FROM alpine:3.7
MAINTAINER pierrecariou <pierrecariou@outlook.fr>
RUN apk update

RUN  apk add influxdb --repository="http://dl-cdn.alpinelinux.org/alpine/edge/community/"

RUN apk add telegraf --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community
RUN mkdir /etc/telegraf
ADD srcs/telegraf.conf /etc/telegraf/

ADD srcs/script.sh /usr/bin/script.sh
CMD ["/bin/ash", "/usr/bin/script.sh"]
