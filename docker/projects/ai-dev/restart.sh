#!/bin/bash

docker rm -f ai-dev

docker run --name ai-dev --restart always --net host -d -v $HOME/projects/ai-dev:/root/ai-dev -w /root/ai-dev -it lightimehpq/ai-dev
