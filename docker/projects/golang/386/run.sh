#!/bin/bash

show_help() {
echo '
Usage example:
    If your GOPATH is /golang, you could build your project as below:

    cd $project-path
    docker run --rm -v $PWD:$PWD -w $PWD -it lightimehpq/golang-386 go build


Customize GOPATH:
    If your GOPATH is NOT /golang, you can set it by -e option:

    cd $project-path
    docker run --rm -v $PWD:$PWD -w $PWD -e GOPATH="/your/go/path" -it lightimehpq/golang-386 go build


Cross compile
    Building your porject for arm architecture by golang-386:

    docker run --rm -v $PWD:$PWD -e GOPATH="/vob/golang" -w $PWD -e GOARCH=arm -it lightimehpq/golang-386 go build


Supported GOOS/GOARCH:
    darwin/386
    freebsd/386
    freebsd/arm
    linux/386 
    linux/arm 
    linux/mips 
    linux/mipsle 
    nacl/386 
    nacl/amd64p32
    nacl/arm
    netbsd/386 
    netbsd/arm 
    openbsd/386 
    openbsd/arm 
    plan9/386 
    plan9/arm 
    windows/386

Supported CC:
    gcc/386
    gcc/arm
'
}

show_help
