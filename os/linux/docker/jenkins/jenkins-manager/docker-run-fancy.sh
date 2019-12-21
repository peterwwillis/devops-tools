#!/bin/sh
. ./docker-run.sh \
    -v ~/.aws:/home/jenkins/.aws \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v jenkins_home:/var/jenkins_home 
