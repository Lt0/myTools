#!/bin/bash

watch -n 1 "cat /proc/cpuinfo | grep "MHz" && echo && echo && sensors && echo && echo && ps -Ao pid,ppid,tty,cputime,etime,%mem,%cpu,args --sort=-%cpu,-%mem | grep -v "ps" | grep -A 5 '  PID  PPID TT'"
