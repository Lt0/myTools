#!/bin/sh

account="lightimehpq"

show_help(){
echo "
Usage:

Start Service Steps:
  1. dump default nfs conf
    docker run --rm ${account}/nfs dumpconf > exports
      It will dump an exmple conf of nfs: exports 
  
  
  2. edit dumped conf: exports.conf
    Please check exports(5) for details: man 5 exports
  
  
  3. stop rpcbind(ubuntu) or portmap(rhel) on host
    service rpcbind stop

  4. start service
    docker run --name=nfs -d --restart=always --privileged=true --net=host -v \$PWD/exports:/etc/exports -v /share_path1:/share_path1 -v /sahre_path2:/share_path2 -it ${account}/nfs start
      - start nfs server container
      - auto start on boot
      - container name is nfs
      - nfs configuration file is ./exports on host, user configuration file is ./user.conf on host
      - /share_pathN is the path that need to be shared

"
}


start_service() {
	if ! [ -d "/run/openrc" ]; then
		mkdir -p /run/openrc
	fi

	if ! [ -f "/run/openrc/softlevel" ]; then
		touch /run/openrc/softlevel
	fi

	rc-update add nfs
	rc-status
	rc-service nfs start
	/bin/sh
}

dumpconf(){
        cat /etc/exports
}

case $# in
        0 )
                show_help
        ;;
        * )
                case $1 in
                        "start" )
                                echo start nfs service
                                start_service
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
esac
     
