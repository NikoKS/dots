#!/bin/sh

docker run \
	-v /var/run/docker.sock:/var/run/docker.sock \
	-v ~:/home \
	-it dev-tool
