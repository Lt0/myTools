FROM ubuntu:18.04
MAINTAINER lightimehpq@gmail.com

RUN apt update && apt install -y apt-mirror python3 cron

RUN echo '0 21 * * * /usr/sbin/redundancy-apt-mirror.sh > /var/log/redundancy-apt-mirror-cron.log' >> /etc/crontab
RUN echo '0 8 * * * ps x | grep redundancy-apt-mirror | grep -v "grep" | awk "{print $1}" | while read ln; do echo killing $ln; kill $ln; done' >> /etc/crontab
RUN echo '0 8 * * * pkill wget' >> /etc/crontab

COPY sources.list /etc/apt/sources.list
COPY mirror.list /etc/apt/mirror.list

COPY redundancy-apt-mirror.sh /usr/sbin/redundancy-apt-mirror.sh
RUN chmod a+x /usr/sbin/redundancy-apt-mirror.sh

COPY run.sh /run.sh
RUN chmod a+x /run.sh

ENTRYPOINT ["/run.sh"]
