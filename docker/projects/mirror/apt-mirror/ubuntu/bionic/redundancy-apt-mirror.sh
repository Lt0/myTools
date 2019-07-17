#!/bin/bash

log_prefix="redundancy-apt-mirror"

switch_over() {
	echo $log_prefix repository switch over
	mv /mirror/apt-mirror-release /mirror/apt-mirror-old
	mv /mirror/apt-mirror /mirror/apt-mirror-release
	mv /mirror/apt-mirror-old /mirror/apt-mirror
}

# test local mirror
update_if_work() {
	echo $(date) - run "apt-get update" to check
	rm -rvf /var/lib/apt/lists/*
	apt-get update
	if [[ $? = "0" ]]; then
		echo $(date) $log_prefix update success
		switch_over
	else
		echo $(date) check result for $log_prefix failed, fallback...
		rm -rvf /var/lib/apt/lists/*
	fi
}

echo $(date) - run "/usr/bin/apt-mirror"
/usr/bin/apt-mirror
if [[ $? = "0" ]]; then
	update_if_work
else
	echo check apt-mirror command result for $log_prefix failed
	exit 1
fi
