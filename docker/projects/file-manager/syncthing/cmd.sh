#!/bin/sh

nohup $APP_PATH/syncthing -no-browser -gui-address="http://0.0.0.0:8384" 1>$LOG_PATH/syncthing.log 2>$LOG_PATH/syncthing_err.log &
/bin/sh
