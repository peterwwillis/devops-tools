FROM jenkins/jenkins:lts

ARG JENKINS_UID=1000
ARG JENKINS_GID=1000
ARG DOCKER_GID=993

USER root

# Create a new /home/jenkins and move the Jenkins user to that home directory.
# Also override the UID and GID for Jenkins and the Docker group.
RUN mkdir -p /home/jenkins \
    && chown jenkins:jenkins -R /home/jenkins \
    && groupadd -g ${DOCKER_GID} docker \
    && groupmod -g ${JENKINS_GID} jenkins \
    && usermod -s /bin/bash -d /home/jenkins -a -G docker jenkins

USER jenkins

COPY plugins.txt /tmp/plugins.txt
RUN /usr/local/bin/install-plugins.sh `cat /tmp/plugins.txt`

# Copy the sample jenkins config into the ref directory.
# This is copied into $JENKINS_HOME at runtime.
# We still want the CASC_JENKINS_CONFIG to point at $JENKINS_HOME, though
RUN mkdir -p /usr/share/jenkins/ref/casc_configs
COPY jenkins.yaml /usr/share/jenkins/ref/casc_configs/jenkins.yaml
ENV CASC_JENKINS_CONFIG=$JENKINS_HOME/casc_configs

# Don't run the setup wizard at start time
# (potentially dangerous if your initial setup doesn't include authentication!)
ENV JAVA_OPTS=-Djenkins.install.runSetupWizard=false
