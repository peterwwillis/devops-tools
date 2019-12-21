# `os/linux/docker/jenkins/`

## Usage
 - To build all the containers in this directory, run:
   ```bash
   $ make
   ```

## Notes

The `jenkins-*` directories here create different Docker containers for Jenkins. These containers are built from the official `jenkinsci/jenkins` containers. Some things to note:

 - The container drops you in as the user `jenkins`. By default, this user's home directory is `/var/jenkins_home`. But this directory is usually volume-mounted in as a persistent volume for Jenkins jobs and configuration, and a user home directory may have a lot of other files in it. So these containers have been modified to add a `/home/jenkins` home directory for the user.

 - The `docker` group has been added, and the `jenkins` user is added to it. You can override the group ID of Docker by passing *DOCKER_GID* as a build argument to `docker build`.

 - The `jenkins` UID and GID can be overridden by passing *JENKINS_UID* and *JENKINS_GID* as build arguments to `docker build`.

## Files

### [jenkins-manager/](./jenkins-manager/)
This directory contains containers and scripts to set up a Jenkins Manager (aka 'Jenkins Master').

### [jenkins-agent/](./jenkins-agent/)
This directory contains containers and scripts to set up a Jenkins Agent (aka 'Jenkins Slave').

