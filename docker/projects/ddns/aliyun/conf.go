package main

import (
	"fmt"
	"io/ioutil"

	"gopkg.in/yaml.v2"
)

// Configuration full configuration definition
type Configuration struct {
	AccessKeyID     string   `yaml:"access_key_id"`
	AccessKeySecret string   `yaml:"access_key_secret"`
	IntervalSecond  int      `yaml:"interval_second"`
	ExternalIPAPI   string   `yaml:"external_ip_api"`
	Domains         []Domain `yaml:"domains"`
}

// Domain domain configuration
type Domain struct {
	Name    string   `yaml:"name"`
	Records []Record `yaml:"records"`
}

// Record DNS resolve record
type Record struct {
	Type string `yaml:"type"`
	TTL  int    `yaml:"TTL"`
	RR   string `yaml:"RR"`
	Line string `yaml:"line"`
}

func initConfig(confPath string) (*Configuration, error) {
	buf, err := ioutil.ReadFile(confPath)
	if err != nil {
		return nil, err
	}

	var config Configuration
	err = yaml.Unmarshal(buf, &config)
	if err != nil {
		return nil, err
	}

	fmt.Printf("config: %+v\n", config)
	if config.IntervalSecond == 0 {
		config.IntervalSecond = 60
	}
	if config.ExternalIPAPI == "" {
		config.ExternalIPAPI = "https://api.ipify.org"
	}

	for _, domain := range config.Domains {
		for _, record := range domain.Records {
			if record.TTL == 0 {
				record.TTL = 600
			}
			if record.Line == "" {
				record.Line = "default"
			}
		}
	}
	return &config, err
}

func (c *Configuration) validate() error {
	if c.AccessKeyID == "" {
		return fmt.Errorf("access_key_id is required")
	}
	if c.AccessKeySecret == "" {
		return fmt.Errorf("access_key_secret is required")
	}
	if c.IntervalSecond <= 0 {
		return fmt.Errorf("interval_second must be greater than 0")
	}
	if c.ExternalIPAPI == "" {
		return fmt.Errorf("external_ip_api is required")
	}
	if len(c.Domains) == 0 {
		return fmt.Errorf("domains is required")
	}
	for _, domain := range c.Domains {
		if domain.Name == "" {
			return fmt.Errorf("domain_name is required")
		}

		for _, record := range domain.Records {
			if record.Type == "" {
				return fmt.Errorf("record type is required")
			}
			if record.RR == "" {
				return fmt.Errorf("record RR is required")
			}
		}
	}
	return nil
}

// DumpExample dump example configuration
func DumpExample(config *Configuration) error {
	data, err := yaml.Marshal(config)
	// data, err := json.MarshalIndent(Config, "", "  ")
	if err != nil {
		return err
	}
	// fmt.Println("Default:", defaultConf)
	fmt.Println(string(data))
	return nil
}
