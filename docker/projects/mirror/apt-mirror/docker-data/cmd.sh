#!/bin/bash

echo "0 1 * * * /usr/bin/apt-mirror > /var/spool/apt-mirror/var/cron.log" | crontab
echo "0 8 * * * pkill apt-mirror" >> /var/spool/cron/crontabs/root
echo "1 8 * * * pkill wget" >> /var/spool/cron/crontabs/root
crontab -l

/usr/sbin/cron
echo crond is running
/bin/bash
