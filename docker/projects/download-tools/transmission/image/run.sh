#!/bin/sh

[ -d "/download/.transmission/" ] || mkdir -p /download/.transmission/
[ -d "/var/log/transmission" ] || mkdir -p /var/log/transmission
[ -d "/download/auto_add" ] || mkdir -p /download/auto_add
[ -d "/download/complete" ] || mkdir -p /download/complete
[ -d "/download/incomplete" ] || mkdir -p /download/incomplete

transmission-daemon --config-dir /download/.transmission/ --logfile /var/log/transmission/transmission.log --watch-dir /download/auto_add
/bin/sh
