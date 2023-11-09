#!/bin/sh

docker build -t my-golang-cross-compile .
docker run -it --rm -v $(pwd):/app my-golang-cross-compile
