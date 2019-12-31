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
 - To clear out the old Jenkins volume (to start from scratch), run:
   ```bash
   $ make docker-clean
   ```
 - To run a bash shell inside a running Jenkins container, run:
   ```bash
   $ make docker-exec
   ```
   Then you can do things like explore the */var/jenkins_home* directory live (as opposed to mounting the volume into another container).

## Files

### `jenkins.yaml`
 - This is the default JCasC configuration, with a default user:password of "admin:admin". Obviously you should change this... There are several examples of JCasC configuration here: https://github.com/jenkinsci/configuration-as-code-plugin/tree/master/demos (I suggest the GitHub-OAuth method)

### `plugins.txt`
 - These are the Jenkins plugins that will be downloaded and installed **at build time**. Best practice is to start with a list like this, then extract the installed versions at run-time, and pin the version numbers in the `plugins.txt` file, so that upgrades in the future don't break your Jenkins jobs. (It's quite common for plugin updates to just randomly break things)

### `env`
 - Environment variables loaded by the `Makefile` and `docker-run.sh` script. Useful variables to note:
   - **DOCKER_GID** - This should be the group ID of the Docker group on your local host. This way when you try to use `/var/run/docker.sock` from a Jenkins container, it will have permissions to write to the socket. This is used by the `Dockerfile` at build time.

### `docker-run.sh`
 - This script will just run the Docker container with the '8080' port exposed, and pass along any command-line arguments. It also creates a Docker volume for `/var/jenkins_home`, and volume-mounts the local directories `~/.aws`, `~/.ssh`, and `/var/run/docker.sock` file, making it easier for you to test Jenkins on your local system.
