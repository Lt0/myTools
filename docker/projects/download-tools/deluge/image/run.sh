#!/bin/sh

deluged -u 0.0.0.0 -c /download/.deluge
deluge-web -f -c /download/.deluge
/bin/sh
