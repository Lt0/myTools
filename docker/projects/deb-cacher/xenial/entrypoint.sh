#!/bin/bash

IMG=lightimehpq/xenial-deb-cacher

show_help() {
echo "
$IMG is a tool for downloading ubuntu 16.04 deb packages with dependencies. All downloaded deb packaeges will be saved in <package_name> dir.

Download packages and it's dependencies:
  docker run --rm -v \$PWD:/pkgs $IMG download <pkg1> [pkg2]...

Using host apt sources.list:
  docker run --rm -v \$PWD:/pkgs -v /etc/apt:/etc/apt $IMG download <pkg1> [pkg2]...

Show help:
  docker run --rm $IMG
"
}


download() {
	apt-get update

	echo Generate offline packages: $*
	for pkg in $*; do
		echo Generate $pkg
		apt install -y -d $pkg
		mkdir /pkgs/$pkg
		mv /var/cache/apt/archives/*.deb /pkgs/$pkg/
	done
}

case $1 in
	download )
		shift
		download $*
		;;
	* )
		show_help
	;;
esac
	
