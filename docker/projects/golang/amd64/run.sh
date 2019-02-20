#!/bin/bash

IMG="lightimehpq/go-amd64"

show_help() {
echo '
Usage example:
    If your GOPATH is /go, you could build your project as below:

    cd $project-path
    docker run --rm -v $PWD:$PWD -w $PWD -it lightimehpq/go-amd64 go build


Customize GOPATH:
    If your GOPATH is NOT /go, you can set it by -e option:

    cd $project-path
    docker run --rm -v $PWD:$PWD -w $PWD -e GOPATH="/your/go/path" -it lightimehpq/go-amd64 go build


Cross compile
    Building your porject for arm64 architecture by go-amd64:

    docker run --rm -v $PWD:$PWD -e GOPATH="/vob/golang" -w $PWD -e GOARCH=arm64 -it lightimehpq/go-amd64 go build
'
}

show_help
