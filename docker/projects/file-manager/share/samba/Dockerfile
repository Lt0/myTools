FROM alpine:3.7
MAINTAINER lightimehpq@gmail.com

# install samba
RUN apk update && apk add --no-cache samba

# conf
RUN mv /etc/samba/smb.conf /etc/samba/default_smb.conf 
COPY tiny_smb.conf /etc/samba/tiny_smb.conf
COPY default_user.conf /etc/samba/default_user.conf

# scripts
COPY run.sh /root/
COPY create_users.sh /root
RUN chmod u+x /root/*.sh 

ENTRYPOINT [ "/root/run.sh" ]
