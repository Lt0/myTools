#!/bin/bash

docker run --rm -u $(id -u):$(id -g) -v $PWD:$PWD -w $PWD --entrypoint sh -it onefetch