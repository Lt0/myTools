package main

import (
	"os"
	"fmt"
	"log"
	"os/exec"
	"io"
	"io/ioutil"
)

func main() {
	if len(os.Args) > 1 && os.Args[1] == "start" {
		fmt.Println("wrag starting loopserver with brook")
		os.Args[1] = "/brook"
		runCmd("/loopservice", os.Args[1:])
		return
	}

	showHelp()
	return
}

func showHelp() {
	fmt.Println(`
brook docker image wraps brook. The brook will be restarted once it exit automatically in container.

Usage:
  Start a brook server:
    docker run --name="brook" -d --restart=always --net=host brook start server -l :your_brook_server_port -p your_brook_server_password

  Start a ssserver:
    docker run --name="ssserver" -d --restart=always --net=host brook start ssserver -l :your_ssserver_port -p your_ssserver_password
	`)
}

func runCmd(service string, args []string) {
	fmt.Printf("wrap Start service: %v %v\n", service, args)
	cmd := exec.Command(service, args...)
	stderr, err := cmd.StderrPipe()
	if err != nil {
		log.Println(err)
	}

	stdout, err := cmd.StdoutPipe()
	if err != nil {
		log.Println(err)
	}

	err = cmd.Start()
	if err != nil {
		log.Println(err)
	}

	readOut(stdout, stderr)

	err = cmd.Wait()
	if err != nil {
		log.Println(err)
	}

}

func readOut(stdout, stderr io.ReadCloser) {
	go readOne(stdout)
	go readOne(stderr)
}

func readOne(rc io.ReadCloser) {
	out, _ := ioutil.ReadAll(rc)
	fmt.Printf("%s\n", out)
}

