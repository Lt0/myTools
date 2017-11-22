docker run --name samba -d --restart=always -v /media/nas-0:/media/nas-0 -v /media/nas-1:/media/nas-1 -v /media/nas-2:/media/nas-2 -p 139:139 -p 445:445 -it samba
