#!/bin/bash
set -e -o pipefail -x

# Set DESTDIR to a root path you want to install the docker files to.
# default is blank to install to your current '/' filesystem.
DESTDIR=build-docker-pkg
ARCH="x86_64"
BUILD="1local"

# Download and install Docker on a Slackware 14.2 system

curl -o output.html https://download.docker.com/linux/static/stable/x86_64/
LATEST_VERSION="$(cat output.html | grep "docker-[0-9]\+\.[0-9]\+\.[0-9]\+\.tgz" | sed -e 's/^.*\(docker-[0-9]\+\.[0-9]\+\.[0-9]\+\.tgz\).*$/\1/g' | sort -V | tail -n1)"

if [ ! -n "$LATEST_VERSION" ] ; then
    echo "Error: could not determine latest version"
    exit 1
fi

BASENAME="$(basename "$LATEST_VERSION" .tgz)"

if [ ! -e "$LATEST_VERSION" ] ; then
    curl -o "$LATEST_VERSION" "https://download.docker.com/linux/static/stable/x86_64/$LATEST_VERSION"
fi

USERDIR=/usr

mkdir -p $DESTDIR$USERDIR/bin
tar -xvzf "$LATEST_VERSION" -C $DESTDIR$USERDIR
( cd $DESTDIR$USERDIR/bin && for i in ../docker/* ; do ln -sf "$i" ; done )
chmod 755 $DESTDIR$USERDIR/bin/*

mkdir -p $DESTDIR/var/lib/docker

mkdir -p $DESTDIR/install
cat > $DESTDIR/install/doinst.sh <<'EOINSTALL'
#!/bin/sh
getent group docker || groupadd -r -g 281 docker
#usermod -aG docker $USER
# as a user, run 'newgrp docker' to initialize new group
EOINSTALL
chmod 755 $DESTDIR/install/doinst.sh

mkdir -p $DESTDIR/etc/rc.d
cat > $DESTDIR/etc/rc.d/rc.docker <<'EORCFILE'
#!/bin/sh
#
# Docker startup script for Slackware Linux
#
# Docker is an open-source project to easily create lightweight, portable,
# self-sufficient containers from any application.

PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin

BASE=dockerd

UNSHARE=/usr/bin/unshare
DOCKER=/usr/bin/${BASE}
DOCKER_PIDFILE=/var/run/${BASE}.pid
DOCKER_LOG=/var/log/docker.log
DOCKER_OPTS=""

# Default options.
if [ -f /etc/default/docker ]; then
  . /etc/default/docker
fi

# Check if docker is present.
if [ ! -x ${DOCKER} ]; then
  echo "${DOCKER} not present or not executable"
  exit 1
fi

docker_start() {
  echo "Starting ${BASE} ..."
  # If there is an old PID file (no dockerd running), clean it up.
  if [ -r ${DOCKER_PIDFILE} ]; then
    if ! ps axc | grep ${BASE} 1> /dev/null 2> /dev/null ; then
      echo "Cleaning up old ${DOCKER_PIDFILE}."
      rm -f ${DOCKER_PIDFILE}
    fi
  fi

  nohup "${UNSHARE}" -m -- ${DOCKER} -p ${DOCKER_PIDFILE} ${DOCKER_OPTS} >> ${DOCKER_LOG} 2>&1 &
}

docker_stop() {
  echo -n "Stopping ${BASE} ..."
  if [ -r ${DOCKER_PIDFILE} ]; then
    DOCKER_PID=$(cat ${DOCKER_PIDFILE})
    kill ${DOCKER_PID}
    while [ -d /proc/${DOCKER_PID} ]; do
      sleep 1
      echo -n "."
    done
  fi
  echo " done"
}

docker_restart() {
  docker_stop
  sleep 1
  docker_start
}

docker_status() {
  if [ -f ${DOCKER_PIDFILE} ] && ps -o cmd $(cat ${DOCKER_PIDFILE}) | grep -q ${BASE} ; then
    echo "Status of ${BASE}: running"
  else
    echo "Status of ${BASE}: stopped"
  fi
}

case "$1" in
  'start')
    docker_start
    ;;
  'stop')
    docker_stop
    ;;
  'restart')
    docker_restart
    ;;
  'status')
    docker_status
    ;;
  *)
    echo "Usage: $0 {start|stop|restart|status}"
esac

exit 0
EORCFILE
chmod 755 $DESTDIR/etc/rc.d/rc.docker

if [ -n "$DESTDIR" ] ; then
    ( OPWD="$(pwd)" && \
      cd "$DESTDIR" && \
        makepkg -c n -l y "$OPWD"/"$BASENAME"-"$ARCH"-"$BUILD".tgz
    )
fi

