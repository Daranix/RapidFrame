#!/bin/sh

docker build -t my-golang-cross-compile .
docker run --rm -v $(pwd):/app my-golang-cross-compile /app/compile.sh
