#!/bin/sh

root="/qbittorrent"
app="qbittorrent"

start_server() {
	[ -f $root/auto_add ] || mkdir -p $root/auto_add
	[ -f $root/torrents ] || mkdir -p $root/torrents
	[ -f $root/complete ] || mkdir -p $root/complete
	[ -f $root/incomplete ] || mkdir -p $root/incomplete
	qbittorrent-nox -d
	/bin/sh
}

show_help() {
echo "
1. Start server
  docker run --name=$app -d --restart=always -v <Host_DIR>:$root -p <Host_Port_For_WebUI>:8080 -p <Host_Port_For_Daemon>:8999 -it $app start
  
  Example:
    docker run --name=$app -d --restart=always -v /qbittorrent:$root -p 8080:8080 -p 8999:8999 -it $app start
      /qbittorrent is dir on host and store downloaded data in it

2. Help
  docker run --rm $app

3. Note
  3.1 Access web UI: <Host_IP>:<Host_Port_For_WebUI>
  3.2 Web UI account: admin/adminadmin
  3.3 Defaul configuration folder is /root/.config$root
"
}

case $# in
	0 )
		show_help
	;;
	1 )
		case $1 in
			"start" )
				echo start $app daemon at $(date)
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
