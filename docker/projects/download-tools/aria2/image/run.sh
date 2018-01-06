#!/bin/sh

aria2c --conf-path=/etc/aria2c.conf
darkhttpd /var/www/html --log /var/log/darkhttpd/darkhttpd.log --daemon

/bin/sh
