#!/bin/bash

sudo cp -vf ddns-namesilo /usr/bin/
sudo cp -vf ddns-namesilo.service /lib/systemd/system
sudo systemctl daemon-reload
sudo systemctl start ddns-namesilo
sudo systemctl enable ddns-namesilo

