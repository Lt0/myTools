FROM ubuntu:14.04
MAINTAINER lightimehpq@gmail.com

#COPY sources.list /etc/apt/sources.list
RUN apt-get update && apt install -y plasma-desktop tightvncserver novnc && rm -rvf /var/cache/apt/*
RUN apt-get install -y konsole dolphin chromium-browser firefox kate
RUN apt-get install -y tcpdump
RUN apt-get install -y vnc4server

COPY index.html /usr/share/novnc/

RUN mkdir /root/.vnc
COPY passwd xstartup /root/.vnc/
RUN chmod a+x /root/.vnc/xstartup
COPY Xauthority /root/.Xauthority

ENV USER=root geometry=1920x1080

COPY entrypoint.sh /opt/entrypoint.sh
ENTRYPOINT [ "/opt/entrypoint.sh" ]
