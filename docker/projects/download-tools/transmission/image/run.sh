#!/bin/sh

[ -d "/download/.transmission/" ] || mkdir -p /download/.transmission/
[ -d "/var/log/transmission" ] || mkdir -p /var/log/transmission
[ -d "/download/auto_add" ] || mkdir -p /download/auto_add

transmission-daemon --config-dir /download/.transmission/ --logfile /var/log/transmission/transmission.log --watch-dir /download/auto_add
/bin/sh
