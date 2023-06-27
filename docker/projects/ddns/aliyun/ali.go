package main

import (
	"fmt"

	alidns20150109 "github.com/alibabacloud-go/alidns-20150109/v4/client"
	openapi "github.com/alibabacloud-go/darabonba-openapi/v2/client"
	"github.com/alibabacloud-go/tea/tea"
)

func createClient(accessKeyID *string, accessKeySecret *string) (_result *alidns20150109.Client, _err error) {
	config := &openapi.Config{
		AccessKeyId:     accessKeyID,
		AccessKeySecret: accessKeySecret,
	}

	config.Endpoint = tea.String("dns.aliyuncs.com")
	_result = &alidns20150109.Client{}
	_result, _err = alidns20150109.NewClient(config)
	return _result, _err
}

func describe(client *alidns20150109.Client, domainName string) (*alidns20150109.DescribeDomainInfoResponse, error) {
	req := alidns20150109.DescribeDomainInfoRequest{
		DomainName: tea.String(domainName),
	}

	return client.DescribeDomainInfo(&req)
}

func describeRecords(client *alidns20150109.Client, domainName string) (*alidns20150109.DescribeDomainRecordsResponse, error) {
	req := alidns20150109.DescribeDomainRecordsRequest{
		DomainName: tea.String(domainName),
	}

	return client.DescribeDomainRecords(&req)
}

func getRecordFromDomainRecords(result *alidns20150109.DescribeDomainRecordsResponse, domainName, RR string) (currentRecord *alidns20150109.DescribeDomainRecordsResponseBodyDomainRecordsRecord) {
	for _, r := range result.Body.DomainRecords.Record {
		if r.DomainName == nil || *r.DomainName != domainName {
			continue
		}
		if r.RR == nil || *r.RR != RR {
			continue
		}

		return r
	}
	return nil
}

// addRecord
// resolveRecord： RR value, e.g. "@", "*"", "www"
func addRecord(client *alidns20150109.Client, domainName string, record Record, ip string) (*alidns20150109.AddDomainRecordResponse, error) {
	req := alidns20150109.AddDomainRecordRequest{
		Line:       tea.String(record.Line),
		DomainName: tea.String(domainName),
		RR:         tea.String(record.RR),
		Type:       tea.String(record.Type),
		Value:      tea.String(ip),
	}
	fmt.Printf("addDomainRecordRequest: %+v\n", req)

	return client.AddDomainRecord(&req)
}

// updateRecord
// recordID: record ID from DescribeDomainRecordsResponse
func updateRecord(client *alidns20150109.Client, recordID string, record Record, ip string) (*alidns20150109.UpdateDomainRecordResponse, error) {
	updateDomainRecordRequest := &alidns20150109.UpdateDomainRecordRequest{
		RecordId: tea.String(recordID),
		RR:       tea.String(record.RR),
		Type:     tea.String(record.Type),
		Line:     tea.String(record.Line),
		Value:    tea.String(ip),
	}

	fmt.Printf("updateDomainRecordRequest: %+v\n", updateDomainRecordRequest)

	return client.UpdateDomainRecord(updateDomainRecordRequest)
}
