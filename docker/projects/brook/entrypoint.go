package main

import (
	"os"
	"fmt"
	"log"
	"os/exec"
)

func main() {
	if len(os.Args) > 1 {
		args := append([]string{"/brook"}, os.Args[1:]...)
		err := runCmd("/loopservice", args)
		if err != nil {
			log.Println("run /loopservice with args:", args)
		}
		return
	}

	showHelp()
	return
}

func runCmd(service string, args []string) error {
	log.Printf("starter start service: %v %v\n", service, args)
	cmd := exec.Command(service, args...)
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	return cmd.Run()
}

func showHelp() {
	fmt.Println(`
brook docker image wraps brook. The brook will be restarted once it exit automatically in container.

Usage:
  Show brook app help:
    docker run --rm brook --help

  Show brook image help:
    docker run --rm brook
    
  Start a brook server:
    docker run --name="brook" -d --restart=always --net=host brook server -l :your_brook_server_port -p your_brook_server_password

  Start a ssserver:
    docker run --name="ssserver" -d --restart=always --net=host brook ssserver -l :your_ssserver_port -p your_ssserver_password

  Start a ssclient:
    docker run --name="ssclient" -d --restart=always --net=host brook ssclient -l 127.0.0.1:8080 -i 127.0.0.1 -s ssserver_ip:ssserver_port -p ssserver_password --http
    export http_proxy=127.0.0.1:8080
    export https_proxy=127.0.0.1:8080
	`)
}
