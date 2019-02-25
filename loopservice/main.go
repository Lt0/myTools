package main

import (
	"os"
	"os/exec"
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
	log.Printf("loopservice start loop service: %v %v\n", service, args)
	cmd := exec.Command(service, args...)

	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	err := cmd.Run()
	if err != nil {
		log.Printf("loopservice run cmd: %v %v failed: %v\n", service, args, err)
	}
}

func showHelp() {
	log.Println("loopservice: no service specified")
}
