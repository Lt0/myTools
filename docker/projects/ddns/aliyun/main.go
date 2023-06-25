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

	for {
		err := updateDNS(accessKeyID, accessKeySecret, domainName, exernalIPAPI)
		if err != nil {
			log.Println("updateDNS err:", err)
		}
		time.Sleep(interval)
	}
}

func updateDNS(accessKeyID, accessKeySecret, domainName, exernalIPAPI string) error {
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

	if !hasDefaultRecord(result) {
		addResult, err := addDefaultRecord(client, domainName, ip)
		if err != nil {
			return fmt.Errorf("addDefaultRecord err: %w", err)
		}
		log.Printf("add default record result: %+v\n", addResult.Body)
		return nil
	}

	defaultRecord := defaultRecord(result)
	if *defaultRecord.Value == ip {
		log.Printf("default record is up to date(%v(record value) == %v(current ip))\n", *defaultRecord.Value, ip)
		return nil
	}

	updateResult, err := updateDefaultRecord(client, *defaultRecord.RecordId, ip)
	if err != nil {
		return fmt.Errorf("update default record err: %w", err)
	}
	log.Printf("update default record result: %+v\n", updateResult.Body)
	return nil
}
