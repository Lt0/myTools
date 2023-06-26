package main

import (
	"fmt"
	"log"
	"os"
	"strconv"
	"time"

	"github.com/alibabacloud-go/tea/tea"
)

func main() {
	domainName := os.Getenv("DOMAIN_NAME")
	if domainName == "" {
		panic("DOMAIN_NAME is empty")
	}

	accessKeyID := os.Getenv("ACCESS_KEY_ID")
	if accessKeyID == "" {
		panic("ACCESS_KEY_ID is empty")
	}

	accessKeySecret := os.Getenv("ACCESS_KEY_SECRET")
	if accessKeySecret == "" {
		panic("ACCESS_KEY_SECRET is empty")
	}

	interval := time.Minute
	envInterval := os.Getenv("INTERVAL_MINUTE")
	if envInterval != "" {
		minutes, err := strconv.ParseInt(envInterval, 10, 64)
		if err != nil {
			panic(fmt.Errorf("INTERVAL_MINUTE err: %w", err))
		}
		interval = time.Duration(minutes) * time.Minute
	}

	exernalIPAPI := "https://api.ipify.org/"
	envExternalIPAPI := os.Getenv("EXTERNAL_IP_API")
	if envExternalIPAPI != "" {
		exernalIPAPI = envExternalIPAPI
	}

	RR := "@"
	envRR := os.Getenv("RR")
	if envRR != "" {
		RR = envRR
	}

	resolveType := "A"
	envResolveType := os.Getenv("RESOLVE_TYPE")
	if envResolveType != "" {
		resolveType = envResolveType
	}

	line := "default"
	envLine := os.Getenv("LINE")
	if envLine != "" {
		line = envLine
	}

	for {
		err := updateDNS(accessKeyID, accessKeySecret, domainName, exernalIPAPI, RR, resolveType, line)
		if err != nil {
			log.Println("updateDNS err:", err)
		}
		time.Sleep(interval)
	}
}

func updateDNS(accessKeyID, accessKeySecret, domainName, exernalIPAPI, resolveRecord, resolveType, line string) error {
	ip, err := getPublicIP(exernalIPAPI)
	if err != nil {
		return fmt.Errorf("getPublicIP err: %w", err)
	}
	log.Println("current public ip:", ip)

	client, err := createClient(tea.String(accessKeyID), tea.String(accessKeySecret))
	if err != nil {
		return fmt.Errorf("createClient err: %w", err)
	}

	result, err := describeRecords(client, domainName)
	if err != nil {
		return fmt.Errorf("describe records err: %w", err)
	}
	log.Printf("current domain name info: %+v\n", result.Body)

	record := getRecord(result, domainName, resolveRecord, resolveType, line)
	if record == nil {
		addResult, err := addRecord(client, domainName, resolveRecord, resolveType, ip, line)
		if err != nil {
			return fmt.Errorf("add record err: %w", err)
		}
		log.Printf("add record result: %+v\n", addResult.Body)
		return nil
	}

	if *record.Value == ip {
		log.Printf("record is up to date(%v(record value in id %v) == %v(current ip)), skip!\n", *record.Value, *record.RecordId, ip)
		return nil
	}

	updateResult, err := updateRecord(client, *record.RecordId, resolveRecord, resolveType, ip, line)
	if err != nil {
		return fmt.Errorf("update default record err: %w", err)
	}
	log.Printf("update default record result: %+v\n", updateResult.Body)
	return nil
}
