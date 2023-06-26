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

func getRecord(result *alidns20150109.DescribeDomainRecordsResponse, domainName, resolveRecord, resolveType, line string) *alidns20150109.DescribeDomainRecordsResponseBodyDomainRecordsRecord {
	for _, record := range result.Body.DomainRecords.Record {
		if record.DomainName == nil || *record.DomainName != domainName {
			continue
		}
		if record.RR == nil || *record.RR != resolveRecord {
			continue
		}
		if record.Type == nil || *record.Type != resolveType {
			continue
		}
		if record.Line == nil || *record.Line != line {
			continue
		}

		return record
	}
	return nil
}

// addDefaultRecord
// domainName: domain name
// resolveRecord： RR value, e.g. "@", "*"", "www"
// resolveType: record type, e.g. "A", "CNAME", "TXT"
// ip: IP address
func addDefaultRecord(client *alidns20150109.Client, domainName, resolveRecord, resolveType, ip string) (*alidns20150109.AddDomainRecordResponse, error) {
	req := alidns20150109.AddDomainRecordRequest{
		Line:       tea.String("default"),
		DomainName: tea.String(domainName),
		RR:         tea.String(resolveRecord),
		Type:       tea.String(resolveType),
		Value:      tea.String(ip),
	}
	fmt.Printf("addDomainRecordRequest: %+v\n", req)

	return client.AddDomainRecord(&req)
}

// addRecord
// resolveRecord： RR value, e.g. "@", "*"", "www"
// resolveType: record type, e.g. "A", "CNAME", "TXT"
// ip: IP address
// line: resolve line, e.g. "default", "telecom", "unicom", "mobile", "oversea", "edu", "drpeng", "btvn", "ctt"
func addRecord(client *alidns20150109.Client, domainName, resolveRecord, resolveType, ip, line string) (*alidns20150109.AddDomainRecordResponse, error) {
	req := alidns20150109.AddDomainRecordRequest{
		Line:       tea.String(line),
		DomainName: tea.String(domainName),
		RR:         tea.String(resolveRecord),
		Type:       tea.String(resolveType),
		Value:      tea.String(ip),
	}
	fmt.Printf("addDomainRecordRequest: %+v\n", req)

	return client.AddDomainRecord(&req)
}

// updateRecord
// recordID: record ID from DescribeDomainRecordsResponse
// resolveRecord： RR value, e.g. "@", "*"", "www"
// resolveType: record type, e.g. "A", "CNAME", "TXT"
// ip: IP address
// line: resolve line, e.g. "default", "telecom", "unicom", "mobile", "oversea", "edu", "drpeng", "btvn", "ctt"
func updateRecord(client *alidns20150109.Client, recordID, resolveRecord, resolveType, ip, line string) (*alidns20150109.UpdateDomainRecordResponse, error) {
	updateDomainRecordRequest := &alidns20150109.UpdateDomainRecordRequest{
		RecordId: tea.String(recordID),
		RR:       tea.String(resolveRecord),
		Type:     tea.String(resolveType),
		Value:    tea.String(ip),
		Line:     tea.String(line),
	}

	fmt.Printf("updateDomainRecordRequest: %+v\n", updateDomainRecordRequest)

	return client.UpdateDomainRecord(updateDomainRecordRequest)
}
