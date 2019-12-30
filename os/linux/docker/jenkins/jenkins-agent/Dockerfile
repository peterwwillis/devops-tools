FROM jenkins/jnlp-slave

LABEL JENKINS_NODE=agent

USER root

COPY jenkins-slave /usr/local/bin/jenkins-slave
#RUN mkdir -p /usr/local/bin \
#    && curl  -o /usr/local/bin/jenkins-slave \
#        https://raw.githubusercontent.com/jenkinsci/docker-jnlp-slave/master/jenkins-agent

USER jenkins

ENTRYPOINT ["jenkins-slave"]
