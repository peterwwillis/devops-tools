#!/bin/sh
set -e -u -x
. ./env

[ ! -d ~/.aws ] && echo "WARNING: You do not have an ~/.aws directory set up"
[ ! -d ~/.ssh ] && echo "Warning: you do not have an ~/.ssh directory set up"

# Only expose JNLP settings if the variables were set in the ./env file
if [ -n "${DOCKER_JENKINS_INTERNAL_JNLP_PORT:-}" ] && [ -n "${DOCKER_JENKINS_EXTERNAL_JNLP_PORT:-}" ] ; then
    JNLP_PORTMAP="-p ${DOCKER_JENKINS_INTERNAL_JNLP_PORT:-}:${DOCKER_JENKINS_EXTERNAL_JNLP_PORT:-} \
                  -e JENKINS_SLAVE_AGENT_PORT=${DOCKER_JENKINS_INTERNAL_JNLP_PORT:-}"
fi

docker run --rm -it \
    -p $DOCKER_JENKINS_INTERNAL_PORT:$DOCKER_JENKINS_EXTERNAL_PORT \
    ${JNLP_PORTMAP:-} \
    -v ~/.aws:/home/jenkins/.aws:ro \
    -v ~/.ssh:/home/jenkins/.ssh:ro \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v jenkins_home:/var/jenkins_home \
    $DOCKER_IMG_NAME:$DOCKER_TAG_NAME \
    "$@"
