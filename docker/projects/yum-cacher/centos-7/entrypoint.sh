#!/bin/bash

IMG=lightimehpq/centos-7-cacher

show_help() {
echo "
$IMG is a tool for downloading centos 7 rpm packages with dependencies. All downloaded rpm packaeges will be saved in <package_name> dir.

Download packages and it's dependencies:
  docker run --rm -v \$PWD:/pkgs $IMG download <pkg1> [pkg2]...

Using host apt sources.list:
  docker run --rm -v \$PWD:/pkgs -v /etc/yum.repos.d:/etc/yum.repos.d $IMG download <pkg1> [pkg2]...

Show help:
  docker run --rm $IMG
"
}


download() {
	echo Generate offline packages: $*
	for pkg in $*; do
		echo Generate $pkg
		mkdir /pkgs/$pkg
		yumdownloader --resolve --destdir /pkgs/$pkg httpd
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
	
