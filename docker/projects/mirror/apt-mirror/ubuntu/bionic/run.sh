#!/bin/bash

IMG=mirror-bionic
CTN_NAME="mirror-bionic"

show_help() {
	echo "
Show help info:
  docker run --rm $IMG help


Start sync service:
  docker run -d --name $CTN_NAME --restart always -v <host_mirror_dir>:/mirror -it $IMG start

Start sync service and using internal http server:
  docker run -d --name $CTN_NAME --restart always -p <host_port>:80 -v <host_mirror_dir>:/mirror -it $IMG start


Sync bionic repository manually to a local dir:
  docker run --rm -v <host_mirror_dir>:/mirror -it $IMG sync
"
}


REL_MIRROR_DIR=/mirror/apt-mirror-release/mirror/mirrors.aliyun.com
TEST_MIRROR_DIR=/mirror/apt-mirror/mirror/mirrors.aliyun.com
start_service() {
	echo $(date) - create mirror dir
	mkdir -p $REL_MIRROR_DIR
	mkdir -p $TEST_MIRROR_DIR

	echo $(date) - start mirror server
	cd $REL_MIRROR_DIR
	python3 -m http.server 80 2>&1 1>/var/log/mirror-server.log &

	echo $(date) - start test mirror server
	cd $TEST_MIRROR_DIR
	python3 -m http.server 8080 2>&1 1>/var/log/mirror-test-server.log &

	cd
	/bin/bash
}

sync() {
	apt-mirror
}


case $1 in
	help | --help | -h )
		show_help
		;;
	start )
		start_service
		;;
	sync )
		sync
		;;
	* )
		show_help
		;;
esac
