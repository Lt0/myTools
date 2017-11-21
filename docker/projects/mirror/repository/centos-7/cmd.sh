#!/bin/bash

echo "0 1 * * * /root/sync.sh > /repository/log/sync.log" | crontab
echo "0 8 * * * /usr/bin/pkill sync.sh" >> /var/spool/cron/root
echo "0 8 * * * /usr/bin/pkill reposync" >> /var/spool/cron/root
echo "0 8 * * * /usr/bin/pkill createrepo" >> /var/spool/cron/root
crontab -l

mkdir -p /repository/log

/usr/sbin/crond &
echo crond is running
/bin/bash
