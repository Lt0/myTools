package main

import (
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

func hasDefaultRecord(result *alidns20150109.DescribeDomainRecordsResponse) bool {
	for _, record := range result.Body.DomainRecords.Record {
		if *record.Line == "default" {
			return true
		}
	}
	return false
}

func defaultRecord(result *alidns20150109.DescribeDomainRecordsResponse) *alidns20150109.DescribeDomainRecordsResponseBodyDomainRecordsRecord {
	for _, record := range result.Body.DomainRecords.Record {
		if *record.Line == "default" {
			return record
		}
	}
	return nil
}

func addDefaultRecord(client *alidns20150109.Client, domainName, ip string) (*alidns20150109.AddDomainRecordResponse, error) {
	req := alidns20150109.AddDomainRecordRequest{
		Line:       tea.String("default"),
		DomainName: tea.String(domainName),
		RR:         tea.String("@"),
		Type:       tea.String("A"),
		Value:      tea.String(ip),
	}

	return client.AddDomainRecord(&req)
}

func updateDefaultRecord(client *alidns20150109.Client, recordID, ip string) (*alidns20150109.UpdateDomainRecordResponse, error) {
	updateDomainRecordRequest := &alidns20150109.UpdateDomainRecordRequest{
		RecordId: tea.String(recordID),
		RR:       tea.String("@"),
		Type:     tea.String("A"),
		Value:    tea.String(ip),
	}

	// fmt.Printf("updateDomainRecordRequest: %+v\n", updateDomainRecordRequest)

	return client.UpdateDomainRecord(updateDomainRecordRequest)
}
