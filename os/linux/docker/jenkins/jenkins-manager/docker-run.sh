#!/bin/sh
set -e -u -x
. ./env
docker run --rm -it -p 8080:8080 $DOCKER_IMG_NAME:$DOCKER_TAG_NAME "$@"
