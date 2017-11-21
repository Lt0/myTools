#!/bin/bash
#Author: zhaolei@casachina.com.cn; hepeiqin@casachina.com.cn

i=0
while true; do 
	if ((i%60==0)); then 
		echo 
	fi; 
	if ((i%720==0)); then 
		date
		((i=0))
	fi;
	ps aux | grep -E "make mobile" | grep -v "grep" | wc -l | awk '{printf $1}'
	sleep 5
	((i++))
done

# Adding below line to /etc/bashrc for create a new alias list_compiler
#alias list_compiler='i=0;while true; do if ((i%60==0)); then echo; fi; if ((i%720==0)); then date;((i=0)); fi; ps aux | grep -E     '\''make +mobile'\'' | wc -l | awk '\''{printf $1}'\'';  sleep 5; ((i++)); done'

