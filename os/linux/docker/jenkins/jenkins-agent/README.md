# `os/linux/docker/jenkins/jenkins-agent/`

## Usage
 - To build the agent container, run:
   ```bash
   $ make
   ```

## About
This directory creates a container to use to build a Jenkins Agent. This agent is used by the Jenkins Manager to run builds or jobs.

### What is a Jenkins Agent?
A Jenkins Agent could also be called a 'build agent'. It contains a Java interpreter and tools to enable it to maintain a bi-directional connection to a Jenkins Manager, so the Manager can control jobs running inside the Agent.

### How is a Jenkins Agent used?
A Jenkins Manager is set up to add 'nodes', which are traditionally an entire computer dedicated to running jobs for Jenkins. The Agent is this 'computer', but it exists as a container rather than a whole physical or virtual machine.

When a Jenkins job is executed on an Agent, the Manager will run commands inside the Agent as instructed by the job. Whatever your job needs to do, it will potentially be doing it inside the Agent container.

It is common to set up an Agent with all the software required for your job/build. You might also have multiple agents set up with different pre-requisites for different kinds of jobs/builds.
