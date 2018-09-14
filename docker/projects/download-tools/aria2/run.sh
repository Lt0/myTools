#!/bin/sh

start_server() {
	if [ -f "/aria2.conf" ]; then
		echo using specified conf: /aria2.conf
	else
		mv /default-aria2.conf /aria2.conf
		echo using default conf
	fi

	if [ -d "/download/.aria2" ]; then
		echo aria2 cache dir /download/.aria2 already exist
	else
		echo create aria2 cache dir /download/.aria2
		mkdir /download/.aria2
		touch /download/.aria2/aria2.session
	fi

	aria2c --conf-path=/aria2.conf --input-file=/download/.aria2/aria2.session
	darkhttpd /var/www/html --log /var/log/darkhttpd/darkhttpd.log --daemon

	/bin/sh
}

dumpconf() {
	cat /aria2.conf
}

show_help() {
echo '
1 start server
  1.1 docker run -d -v /download:/download -p 6800:6800 -p 6789:80 -it aria2 start
    - start an aria2 server
    - using default configuration
    - download path is /download on host
    - aria2 client connect server from IP:6800 
    - access web ui from localhost:6789

  1.2 docker run --name=aria2 -d --restart=always -v /download:/download -v ./aria2.conf:/aria2.conf -p 6800:6800 -p 6789:80 -it aria2 start
    - start an aria2 server
    - auto start on boot
    - container name is aria2
    - configuration file is ./aria2.conf on host
    - aria2 client connect server from IP:6800
    - access web ui from localhost:6789

2 dump configuration
  2.1 docker run --rm aria2 dumpconf
    - dump default aria2 configuration
    - remove the container after dump configuration

3 help
  3.1 docker run --rm aria2 -h
    - show current help, h|-h|--h|help|-help|--help option will show current help info.
    - remove the container after show help info



Please check https://hub.docker.com/r/lightimehpq/aria2 for more details. 



If you think it is a nice image, please star the project on github.com:
https://github.com/Lt0/myTools/tree/master/docker/projects/download-tools/aria2

Thanks a lot!
'
}

case $# in
	0 )
		show_help
	;;
	1 )
		case $1 in
			"start" )
				echo start aria2
				start_server
			;;
			"dumpconf" )
				dumpconf
			;;
			"h" | "help" | "-h" | "--help" | "-help" | "--h" ) 
				show_help
			;;
			* )
				echo unknow option: $*
				show_help
			;;
		esac
	;;
	* )
		echo unknown option: $*
		show_help
	;;
esac
