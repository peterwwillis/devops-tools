# `os/linux/docker/jenkins/jenkins-manager/`

## About
This directory builds the Jenkins Manager (aka 'Jenkins Master') container.

## Usage
Prerequisites: Docker, Make.

 - To build the container, run:
   ```bash
   $ make docker-build
   ```
 - To run the container, run:
   ```bash
   $ ./docker-run.sh
   ```

## Files

### `docker-run.sh`
 - This script will just run the Docker container with the '8080' port exposed, and pass along any command-line arguments. It also volume-mounts `/var/jenkins_home`, `~/.aws`, and `/var/run/docker.sock`, making it easier for you to test Jenkins on your local system.
