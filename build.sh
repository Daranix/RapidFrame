#!/bin/sh

docker build -t daranix/golang-cross-compile .
docker run --platform="linux/amd64" -it --rm -v $(pwd):/app daranix/golang-cross-compile /app/compile.sh
