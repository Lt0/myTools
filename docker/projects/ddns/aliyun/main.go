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

	for {
		ip, err := getPublicIP()
		if err != nil {
			log.Printf("get public ip err: %v\n", err)
			time.Sleep(time.Second * time.Duration(config.IntervalSecond))
			continue
		}
		log.Println("current public ip:", ip)

		for _, domain := range config.Domains {
			err := updateDomain(client, ip, domain)
			if err != nil {
				log.Printf("updateDomain err: %v\n", err)
			}
		}

		time.Sleep(time.Second * time.Duration(config.IntervalSecond))
	}
}

func updateDomain(client *alidns20150109.Client, ip string, domain Domain) error {
	result, err := describeRecords(client, domain.Name)
	if err != nil {
		return fmt.Errorf("%s: describe records err: %w", domain.Name, err)
	}
	log.Printf("%s: current domain name info: %+v\n", domain.Name, result.Body)

	for _, record := range domain.Records {
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
	      - type: "A"           			# required, e.g: "A", "CNAME", "AAA", "TXT"...
	        RR: "@"             			# required, e.g: "@", "www", "*", "abc.def"...
	        TTL: 600            			# optional, default 600
	        line: "default"     			# optional, default "default"
	      - type: "A"           
	        RR: "*"             
`
