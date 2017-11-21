FROM apt-mirror-base
MAINTAINER hepeiqin@casachina.com.cn

COPY docker-data/sources.list /etc/apt/sources.list
RUN apt-get update && apt-get install -y apt-mirror

COPY docker-data/mirror.list /etc/apt/mirror.list
COPY docker-data/cmd.sh /root/
RUN chmod a+x /root/cmd.sh

CMD ["sh", "-c", "/root/cmd.sh"]
