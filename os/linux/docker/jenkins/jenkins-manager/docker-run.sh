#!/bin/sh
set -e -u -x
. ./env
docker run --rm -it \
    -p $DOCKER_JENKINS_INTERNAL_PORT:$DOCKER_JENKINS_EXTERNAL_PORT \
    -v ~/.aws:/home/jenkins/.aws:ro \
    -v ~/.ssh:/home/jenkins/.ssh:ro \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v jenkins_home:/var/jenkins_home \
    $DOCKER_IMG_NAME:$DOCKER_TAG_NAME \
    "$@"
