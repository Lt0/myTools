package main

import (
	"crypto/rand"
	"errors"
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

var ipQueryAPIs = []string{}

func getRandomAPI(ipType string) (string, error) {
	ipv4APIs := []string{
		"https://api.ipify.org?format=text",
		"https://ipv4.icanhazip.com",
		"https://checkip.amazonaws.com",
	}

	ipv6APIs := []string{
		"https://api6.ipify.org?format=text",
		"https://ipv6.icanhazip.com",
		"https://checkipv6.dyndns.com",
	}

	var apis []string
	switch ipType {
	case "ipv4":
		apis = ipv4APIs
	case "ipv6":
		apis = ipv6APIs
	default:
		return "", errors.New("invalid ipType: must be 'ipv4' or 'ipv6'")
	}

	idx, err := rand.Int(rand.Reader, big.NewInt(int64(len(apis))))
	if err != nil {
		return apis[0], nil
	}

	// fmt.Printf("Using API: %v: %v\n", idx.Int64(), ipQueryAPIs[idx.Int64()])
	return apis[idx.Int64()], nil
}

func getPublicIP(ipType string) (ip string, err error) {
	for i := 0; i < maxRetries; i++ {
		api, err := getRandomAPI(ipType)
		if err != nil {
			return "", fmt.Errorf("Error getting random API: %v", err)
		}
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
