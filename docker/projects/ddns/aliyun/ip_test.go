package main

import "testing"

func TestGetRandomAPI(t *testing.T) {
	ipTypes := []string{"ipv4", "ipv6"}
	for _, ipType := range ipTypes {
		for i := 0; i < 10; i++ {
			api, err := getRandomAPI(ipType)
			if err != nil {
				t.Errorf(err.Error())
				continue
			}
			t.Log(api)
		}
	}
}

func TestGetPublicIP(t *testing.T) {
	ipType := []string{"ipv4", "ipv6"}
	for _, ip := range ipType {
		ipAddr, err := getPublicIP(ip)
		if err != nil {
			t.Errorf("Error getting public IP: %v", err)
			continue
		}
		t.Logf("Public IP (%s): %s\n", ip, ipAddr)
	}
}
