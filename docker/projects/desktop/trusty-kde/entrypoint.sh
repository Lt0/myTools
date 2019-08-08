#!/bin/bash

IMG=trusty-kde
CTN=trusty-kde

show_help() {
echo "
Start desktop:
  docker run -d --name $CTN -p <vnc-port>:5901 -p <web-vnc-port>:6901 -it $IMG start

  e.g:
    docker run -d --name $CTN -p 5901:5901 -p 6901:6901 -it $IMG start



Start desktop and set geometry:
  docker run -d --name $CTN -p <vnc-port>:5901 -p <web-vnc-port>:6901 -e geometry=<WIDTH>x<HEIGHT> -it $IMG start

  e.g:
    docker run -d --name $CTN -p 5901:5901 -p 6901:6901 -e geometry=1920x1080 -it $IMG start
    docker run -d --name $CTN -p 5901:5901 -p 6901:6901 -e geometry=1600x900 -it $IMG start
    docker run -d --name $CTN -p 5901:5901 -p 6901:6901 -e geometry=1366x768 -it $IMG start
    docker run -d --name $CTN -p 5901:5901 -p 6901:6901 -e geometry=1280x1024 -it $IMG start
    docker run -d --name $CTN -p 5901:5901 -p 6901:6901 -e geometry=1152x864 -it $IMG start
    docker run -d --name $CTN -p 5901:5901 -p 6901:6901 -e geometry=1024x768 -it $IMG start
    docker run -d --name $CTN -p 5901:5901 -p 6901:6901 -e geometry=800x600 -it $IMG start


Change vncserver password:
  docker exec -it $CTN tightvncpasswd


Note:
  1. Default geometry is 1920x1080
  2. Default passwd is lightime
"
}

start_desktop() {
	echo "$(date) - Start desktop with $geometry"
	vncserver -geometry $geometry
	websockify -D --web=/usr/share/novnc/ 6901 localhost:5901
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
