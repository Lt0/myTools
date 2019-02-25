#!/bin/bash

go build entrypoint.go
docker build -t brook .
