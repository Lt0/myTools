#!/bin/bash

IMG=bionic-lxde
CTN=bionic-lxde

show_help() {
echo "
Start desktop:
  docker run -d --name $CTN -p <vnc-port>:5901 -p <web-vnc-port>:6901 -p <xrpd-port>:3389 -it $IMG start

  e.g:
    docker run -d --name $CTN -p 5901:5901 -p 6901:6901 -p 3389:3389 -it $IMG start



Start desktop and set geometry:
  docker run -d --name $CTN -p <vnc-port>:5901 -p <web-vnc-port>:6901 -p <xrpd-port>:3389 -e geometry=<WIDTH>x<HEIGHT> -it $IMG start

  e.g:
    docker run -d --name $CTN -p 5901:5901 -p 6901:6901 -p 3389:3389 -e geometry=1920x1080 -it $IMG start
    docker run -d --name $CTN -p 5901:5901 -p 6901:6901 -p 3389:3389 -e geometry=1600x900 -it $IMG start
    docker run -d --name $CTN -p 5901:5901 -p 6901:6901 -p 3389:3389 -e geometry=1366x768 -it $IMG start
    docker run -d --name $CTN -p 5901:5901 -p 6901:6901 -p 3389:3389 -e geometry=1280x1024 -it $IMG start
    docker run -d --name $CTN -p 5901:5901 -p 6901:6901 -p 3389:3389 -e geometry=1152x864 -it $IMG start
    docker run -d --name $CTN -p 5901:5901 -p 6901:6901 -p 3389:3389 -e geometry=1024x768 -it $IMG start
    docker run -d --name $CTN -p 5901:5901 -p 6901:6901 -p 3389:3389 -e geometry=800x600 -it $IMG start


Start desktop with customized vnc password:
  docker run -d --name $CTN -p <vnc-port>:5901 -p <web-vnc-port>:6901 -p <xrpd-port>:3389 -e VNC_PASSWD=<you_password> -it $IMG start


Change vncserver password:
  docker exec -it $CTN vncpasswd


Note:
  1. Default geometry is 1920x1080
  2. Default passwd is lightime
"
}

start_desktop() {
	echo "$(date) - Start VNC desktop with $geometry"
	vncserver -geometry $geometry << !PWD!
$VNC_PASSWD
$VNC_PASSWD
!PWD!

	echo "$(date) - Start VNC Web Server"
	websockify -D --web=/usr/share/novnc/ 6901 localhost:5901

	echo "$(date) - Start XRDP"
	xrdp

	bash
}

case $1 in
	start )
		start_desktop
	;;
	* )
		show_help
	;;
esac
