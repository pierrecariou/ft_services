FROM alpine:3.7
MAINTAINER pierrecariou <pierrecariou@outlook.fr>
RUN apk update

#RUN apk add curl
#RUN apk add gnupg
#RUN curl -s https://repos.influxdata.com/influxdb2.key | gpg --import - 
#RUN wget https://dl.influxdata.com/influxdb/releases/influxdb2-2.0.3_linux_amd64.tar.gz
#RUN tar xvzf influxdb2-2.0.3_linux_amd64.tar.gz
#RUN	cp influxdb2-2.0.3_linux_amd64/influxd influxdb2-2.0.3_linux_amd64/influx /usr/local/bin/ 
RUN  apk add influxdb --repository="http://dl-cdn.alpinelinux.org/alpine/edge/community/"

RUN apk add telegraf --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community
RUN mkdir /etc/telegraf
#RUN telegraf config > /etc/telegraf/telegraf.conf
ADD srcs/telegraf.conf /etc/telegraf/

ADD srcs/script.sh /usr/bin/script.sh
CMD ["/bin/ash", "/usr/bin/script.sh"]
