package main

import (
	"fmt"
	"os"
	"os/exec"
	"io"
	"io/ioutil"
	"log"
	"time"
)


func init() {
	log.SetFlags(log.Lshortfile | log.LstdFlags)
}

func main() {
	if len(os.Args) < 2 {
		showHelp()
		return
	}

	for true {
		runCmd(os.Args[1], os.Args[2:])
		time.Sleep(3 * time.Second)
	}
}

func runCmd(service string, args []string) {
	fmt.Printf("Start loop service: %v %v\n", service, args)
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

func showHelp() {
	fmt.Println("loopservice: no service specified")
}
