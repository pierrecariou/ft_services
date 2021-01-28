#!/usr/bin/env bash

influxd &
#echo "CREATE DATABASE telegraf" | influx
#echo "CREATE USER pcariou WITH PASSWORD 'user42' WITH ALL PRIVILEGES" | influx

influx -execute "CREATE DATABASE influx_db"
influx -execute “CREATE USER pcariou WITH PASSWORD 'user42'”
influx -execute “GRANT ALL ON influx_db TO pcariou

telegraf

#/bin/ash
