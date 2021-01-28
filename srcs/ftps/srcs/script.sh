#!/usr/bin/env bash

adduser -D pcariou
echo pcariou:user42 | chpasswd
echo pcariou > /etc/vsftpd.userlist

telegraf &
/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
