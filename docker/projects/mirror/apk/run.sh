#!/bin/sh

crond &
darkhttpd /var/www/html --port 80 &
/bin/sh
