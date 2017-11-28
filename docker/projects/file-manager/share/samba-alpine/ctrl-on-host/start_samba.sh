docker run --name samba -d --restart=always -v /vob:/vob -p 139:139 -p 445:445 -it samba:alpine
