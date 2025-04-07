package main

import (
	"flag"
	"fmt"
	"log"
	"time"

	alidns20150109 "github.com/alibabacloud-go/alidns-20150109/v4/client"
	"github.com/alibabacloud-go/tea/tea"
)

func main() {
	configPath := flag.String("c", "/etc/aliddns.yaml", fmt.Sprintf("config file path.\nconfig yaml file example:%s\n", configExample))
	flag.Parse()
	log.Println("config path:", *configPath)
	config, err := initConfig(*configPath)
	if err != nil {
		log.Fatalln("initConfig err:", err)
	}

	if err = config.validate(); err != nil {
		log.Fatalln("config validate err:", err)
	}

	client, err := createClient(tea.String(config.AccessKeyID), tea.String(config.AccessKeySecret))
	if err != nil {
		log.Fatalln("createClient err: %w", err)
	}

	hasRecordA := false
	hasRecordAAAA := false
	for _, domain := range config.Domains {
		for _, record := range domain.Records {
			if record.Type == "A" {
				hasRecordA = true
			} else if record.Type == "AAAA" {
				hasRecordAAAA = true
			}
		}
	}

	for {
		ipv4 := ""
		ipv6 := ""
		if hasRecordA {
			ipv4, err = getPublicIP("ipv4")
			if err != nil {
				log.Printf("get public ip err: %v\n", err)
				time.Sleep(time.Second * time.Duration(config.IntervalSecond))
				continue
			}
		}
		if hasRecordAAAA {
			ipv6, err = getPublicIP("ipv6")
			if err != nil {
				log.Printf("get public ip err: %v\n", err)
				time.Sleep(time.Second * time.Duration(config.IntervalSecond))
				continue
			}
		}
		log.Printf("current public ip4: %v, ipv6: %v\n", ipv4, ipv6)

		for _, domain := range config.Domains {
			err := updateDomain(client, ipv4, ipv6, domain)
			if err != nil {
				log.Printf("updateDomain err: %v\n", err)
			}
		}

		time.Sleep(time.Second * time.Duration(config.IntervalSecond))
	}
}

func updateDomain(client *alidns20150109.Client, ipv4, ipv6 string, domain Domain) error {
	result, err := describeRecords(client, domain.Name)
	if err != nil {
		return fmt.Errorf("%s: describe records err: %w", domain.Name, err)
	}
	log.Printf("%s: current domain name info: %+v\n", domain.Name, result.Body)

	for _, record := range domain.Records {
		ip := ipv4
		if record.Type == "AAAA" {
			ip = ipv6
		}

		currentRecord := getRecordFromDomainRecords(result, domain.Name, record.RR)

		// add record if current record is nil
		if currentRecord == nil {
			addResult, err := addRecord(client, domain.Name, record, ip)
			if err != nil {
				return fmt.Errorf("%s: add record err: %w", domain.Name, err)
			}
			log.Printf("%s: add record result: %+v\n", domain.Name, addResult.Body)
			continue
		}

		// skip update if current record value is equal to ip
		if currentRecord.Value != nil && *currentRecord.Value == ip {
			log.Printf("%s: record %s value is %s, skip update\n", domain.Name, record.RR, *currentRecord.Value)
			continue
		}

		// update record if current record value is not equal to ip
		updateResult, err := updateRecord(client, *currentRecord.RecordId, record, ip)
		if err != nil {
			return fmt.Errorf("update record err: %w", err)
		}
		log.Printf("%s: update record result: %+v\n", domain.Name, updateResult.Body)
	}
	return nil
}

const configExample = `
	access_key_id: xxxxxxxxxxxxxxxx           	# required, ali cloud access key id
	access_key_secret: xxxxxxxxxxxxxxxx       	# required, ali cloud access key secret
	interval_second: 60                       	# optional, default 60
	domains:
	  - domain:
	    name: "lt0.fun"         			# required
	    records:			
	      - type: "A"           			# required, e.g: "A", "CNAME", "AAAA", "TXT"...
	        RR: "@"             			# required, e.g: "@", "www", "*", "abc.def"...
	        TTL: 600            			# optional, default 600
	        line: "default"     			# optional, default "default"
	      - type: "A"           
	        RR: "*"             
`
