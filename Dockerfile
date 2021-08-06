FROM jenkins/jenkins:2.263.4-lts-jdk11
RUN jenkins-plugin-cli --plugins pipeline-model-definition git:4.7.2
