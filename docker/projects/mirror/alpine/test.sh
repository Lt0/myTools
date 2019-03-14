#!/bin/bash

image="alpine-mirror"

case $1 in
	"size" )
		docker run --rm $image size
		;;
	"start" )
		docker run --rm -it $image start
		;;
	"run" )
		docker run --rm $image run
		;;
	"dumpconf" )
		docker run --rm $image dumpconf
		;;
	* )
		docker run --rm $image
		;;
esac
