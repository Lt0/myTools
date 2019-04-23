#!/bin/sh

start_server() {
	[ -f /deluge/auto_add ] || mkdir -p /deluge/auto_add
	[ -f /deluge/torrents ] || mkdir -p /deluge/torrents
	[ -f /deluge/complete ] || mkdir -p /deluge/complete
	[ -f /deluge/incomplete ] || mkdir -p /deluge/incomplete
	deluged -u 0.0.0.0
	deluge-web -f
	/bin/sh
}

show_help() {
echo '
1. Start server
  docker run --name=deluge -d --restart=always -v <Host_DIR>:/deluge -p 8112:8112 -it deluge start
  
  Example:
    docker run --name=deluge -d --restart=always -v /download:/deluge -p 8112:8112 -it deluge start
      /download is dir on host and store downloaded data

2. Help
  docker run --rm deluge

3. Note
  3.1 Access web UI: localhost:8112
  3.2 Web UI password: deluge
  3.3 Defaul configuration folder is /root/.config/deluge
  3.4 In configuration folder, core.conf is daemon configuration, web.conf is deluge-web configuration
'
}

case $# in
	0 )
		show_help
	;;
	1 )
		case $1 in
			"start" )
				echo start deluge at $(date)
				start_server
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
