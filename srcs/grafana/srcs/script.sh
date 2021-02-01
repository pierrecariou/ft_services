#!/usr/bin/env bash

telegraf &
grafana-server -homepath "/usr/share/grafana"
