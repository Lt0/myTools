package main

import "testing"

func TestGetRandomAPI(t *testing.T) {
	for i := 0; i < 10; i++ {
		api := getRandomAPI()
		t.Log(api)
	}
}

func TestGetPublicIP(t *testing.T) {
	ip, err := getPublicIP()
	if err != nil {
		t.Errorf(err.Error())
	}

	t.Log(ip)
}
