#!/bin/sh

image="alpine-mirror"

show_help() {
	echo "
Usage:
  Start apk mirror server
    docker run --name $image --restart=always -d -it $image start


  start apk mirror server with web service
    docker run --name $image --restart=always -p 80:80 -d -it $image start


  Start apk mirror server with customized configuration
    step 1: get example configuration
      docker run --rm $image dumpconf > alpine-mirror.conf

    step 2: edit alpine-mirror.conf
    
    step 3: start service
      docker run --name $image --restart=always -v $PWD/alpine-mirror.conf:/etc/alpine-mirror.conf -d -it $image start
 
      Or start service with web service:
        docker run --name $image --restart=always -v $PWD/alpine-mirror.conf:/etc/alpine-mirror.conf -d -p 80:80 -it $image start
     

  
  Show mirror size
    docker run --rm apk-mirror size


  Run sync one time and store all files to host(/mirror)
    dockerr un --rm -v /mirror:/mirror $image run


  Show default configuration
    docker run --rm $image dumpconf

Note:
1. All synced files located at /mirror in container
"
}

start() {
	crond &
	/usr/bin/darkhttpd /mirror --port 80 --log /var/log/darkhttpd.log --daemon > /var/log/darkhttpd.log 2>&1
	/bin/sh
}

case $1 in
	size )
		echo "counting size in (GB)"
		/alpine-mirror-size.sh
		;;
	dumpconf )
		cat /etc/alpine-mirror.conf
		;;
	start )
		echo start mirror service at $(date)
		start
		;;
	run )
		echo run alpine-mirror at $(date)
		/etc/periodic/daily/alpine-mirror
		#/etc/periodic/15min/alpine-mirror
		echo alpine-mirror finish at $(date)
		;;
	-h | --help | * )
		show_help
		;;
esac
