#!/bin/bash

export ACCESS_KEY_ID=xxx
export ACCESS_KEY_SECRET=xxx
export DOMAIN_NAME=lt0.fun

docker run --name aliddns \
--restart always \
-d \
-v /etc/localtime:/etc/localtime \
-e DOMAIN_NAME=lt0.fun \
-e ACCESS_KEY_ID="$ACCESS_KEY_ID" \
-e ACCESS_KEY_SECRET="$ACCESS_KEY_SECRET" \
-e INTERVAL_MINUTE=2 \
-e EXTERNAL_IP_API="https://myexternalip.com/raw" \
-it aliddns

docker logs -f aliddns