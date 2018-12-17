#!/bin/sh

subcommand=$1

show_help() {
	echo '
Usage:
  1. Add internal addresses conf in a new directoy: $PWD/dnsmasq.d
  2. Internal addresses conf example:
    cat $PWD/dnsmasq.d/*.conf
    address=/test.com/172.0.5.75
    address=/test2.com/172.0.5.76
  3. Start DNS server:
    docker run -d --name=dns --restart=always --net=host -p 53:53 -v $PWD/dnsmasq.d:/etc/dnsmasq.d dns start
  

Show help:
  docker run --rm dns
  docker run --rm dns -h
  docker run --rm dns --help


Start DNS server:
  docker run -d --name=dns --restart=always --net=host -p 53:53 -v /path/to/dnsmasq.d:/etc/dnsmasq.d dns start


Check log:
  docker logs dns
  docker logs -f dns


Modify conf:
  1. Edit dnsmasq.d/*.conf
  2. docker restart dns


Define Hosts:
  You can define hosts in dnsmasq.d/hosts directly.


Note:
  1. /etc/dnsmasq-upstream-servers.conf defines upstream servers of DNS server. This file was copied in image when building.
	'
}

start_dns() {
	shift
	echo start dnsmasq with options: $*

	echo -n "#################"
	echo -n " addresses "
	echo "#################"
	cat /etc/dnsmasq.d/*.conf
	echo -n "#################"
	echo -n " addresses "
	echo "#################"

	/usr/sbin/dnsmasq -d $*
}

case $subcommand in
	start )
		echo start dns server at $(date)
		start_dns
		;;
	-h | --help )
		show_help
		;;
	* )
		echo unknow sub command: $*
		show_help
		;;
esac
