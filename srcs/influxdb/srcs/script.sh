#!/usr/bin/env bash

influxd &

if ! influxdb -execute "SHOW DATABASES" | grep influx_db
then
	influx -execute "CREATE DATABASE influx_db"
	influx -execute “CREATE USER pcariou WITH PASSWORD 'user42'”
	influx -execute “GRANT ALL ON influx_db TO pcariou
fi

telegraf
