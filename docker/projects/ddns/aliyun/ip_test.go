package main

import "testing"

func TestGetPublicIP(t *testing.T) {
	ip, err := getPublicIP()
	if err != nil {
		t.Errorf(err.Error())
	}

	t.Log(ip)
}
