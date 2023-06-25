package main

import (
	"io/ioutil"
	"net/http"
	"strings"
)

func getPublicIP(apiURL string) (ip string, err error) {
	resp, err := http.Get(apiURL)
	if err != nil {
		return
	}
	defer resp.Body.Close()

	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		return
	}

	ip = strings.TrimSpace(string(body))
	return
}
