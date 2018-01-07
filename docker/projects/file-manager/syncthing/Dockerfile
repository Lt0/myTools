FROM alpine:3.7
MAINTAINER lightimehpq@gmail.com

ENV APP_PATH="/opt/syncthing"
ENV LOG_PATH="/var/log/syncthing"
ENV CMD_FILE="cmd.sh"
ENV RUN_USER="vcube"
ARG RUN_PSWD="vcube"


RUN mkdir -p $APP_PATH
COPY pkg/syncthing $CMD_FILE $APP_PATH/
RUN chmod a+x $APP_PATH/$CMD_FILE && mkdir -p $LOG_PATH && adduser -D $RUN_USER && echo "$RUN_PSWD:$RUN_PSWD" | chpasswd && chown $RUN_USER:$RUN_USER $LOG_PATH
USER $RUN_USER
WORKDIR /home/$RUN_USER

CMD [ "sh", "-c", "$APP_PATH/$CMD_FILE" ]
