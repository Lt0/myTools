FROM lightimehpq/bionic-lxde-base
MAINTAINER lightimehpq@gmail.com

# Install lxde vnc4server novnc manually in lightimehpq/bionic-lxde-base
#RUN apt-get update && apt-get install -y lxde vnc4server novnc

RUN sed -i s/archive.ubuntu.com/mirrors.aliyun.com/g /etc/apt/sources.list
RUN sed -i s/security.ubuntu.com/mirrors.aliyun.com/g /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y xrdp
RUN apt-get install -y firefox

COPY index.html /usr/share/novnc/

RUN mkdir /root/.vnc
COPY xstartup /root/.vnc/
RUN chmod a+x /root/.vnc/xstartup
COPY Xauthority /root/.Xauthority

ENV USER=root geometry=1920x1080
ENV VNC_PASSWD=lightime

COPY entrypoint.sh /opt/entrypoint.sh
ENTRYPOINT [ "/opt/entrypoint.sh" ]
