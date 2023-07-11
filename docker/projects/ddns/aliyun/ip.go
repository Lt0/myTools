package main

import (
	"crypto/rand"
	"fmt"
	"io"
	"math/big"
	"net"
	"net/http"
	"strings"
	"time"
)

// func getPublicIP(apiURL string) (ip string, err error) {
// 	resp, err := http.Get(apiURL)
// 	if err != nil {
// 		return
// 	}
// 	defer resp.Body.Close()

// 	body, err := ioutil.ReadAll(resp.Body)
// 	if err != nil {
// 		return
// 	}

// 	ip = strings.TrimSpace(string(body))
// 	return
// }

const maxRetries = 10

var ipQueryAPIs = []string{
	"https://api.ipify.org",
	"https://api64.ipify.org",
	"https://ipify2.opencnam.com",
	"https://ifconfig.me/ip",
	"https://ifconfig.co/ip",
	"https://icanhazip.com",
	"https://ipinfo.io/ip",
	"https://api.ip.sb/ip",
	"https://checkip.amazonaws.com",
	"https://www.trackip.net/ip",
	"https://myexternalip.com/raw",
	"https://ip.seeip.org",
}

func getRandomAPI() string {
	idx, err := rand.Int(rand.Reader, big.NewInt(int64(len(ipQueryAPIs))))
	if err != nil {
		return ipQueryAPIs[len(ipQueryAPIs)-1]
	}

	// fmt.Printf("Using API: %v: %v\n", idx.Int64(), ipQueryAPIs[idx.Int64()])
	return ipQueryAPIs[idx.Int64()]
}

func getPublicIP() (ip string, err error) {
	for i := 0; i < maxRetries; i++ {
		api := getRandomAPI()
		resp, err := http.Get(api)
		if err != nil {
			fmt.Printf("Error making request to %s: %v\n", api, err)
			continue
		}
		defer resp.Body.Close()

		if resp.StatusCode == http.StatusOK {
			ipBytes, err := io.ReadAll(resp.Body)
			if err != nil {
				fmt.Printf("Error reading response body from %s: %v\n", api, err)
				time.Sleep(time.Second) // sleep 1s to avoid get the same API if failed very fast
				continue
			}
			ip = strings.TrimSpace(string(ipBytes))
			if !isValidIP(ip) {
				continue
			}
			break
		}
	}

	if ip == "" {
		return "", fmt.Errorf("Failed to retrieve IP address after %d retries", maxRetries)
	}

	return ip, nil
}

func isValidIP(ip string) bool {
	return net.ParseIP(ip) != nil
}
