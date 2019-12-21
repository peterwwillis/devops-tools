# `os/linux/docker/jenkins/jenkins-manager/`

## Usage
 - To build the container, run:
   ```bash
   $ make
   ```

## About

This directory builds the Jenkins Manager (aka 'Jenkins Master') container.

## Files

### `docker-run.sh`
 - This script will just run the Docker container with the '8080' port exposed, and pass along any command-line arguments.

### `docker-run-fancy.sh`
 - This script uses the above script, but also volume-mounts `/var/jenkins_home`, `~/.aws`, and `/var/run/docker.sock`, making it easier for you to test Jenkins on your local system.
