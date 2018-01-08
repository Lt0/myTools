#!/bin/sh

aria2c --conf-path=/download/.aria2/aria2.conf --input-file=/download/.aria2/aria2.session
darkhttpd /var/www/html --log /var/log/darkhttpd/darkhttpd.log --daemon

/bin/sh
