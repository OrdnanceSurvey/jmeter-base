#
# Dockerfile for a base jmeter image
#
# Usage:
# It is unlikely that you will need to run this image.
# It forms the basis for other images.
#

FROM ubuntu:18.04
MAINTAINER Nathan.Meys@os.uk

# Describe the environment
#ENV JDK_VERSION 1.7.0
ENV JMETER_VERSION 4.0

RUN apt-get update -y && apt-get install -y sudo
RUN sudo apt-get upgrade -y
RUN apt-get install curl -y
RUN apt-get install unzip -y

# Install the JDK
RUN  apt-get install openjdk-8-jdk -y

# Install JMeter 4.0 and the Custom Thread Groups plugin
RUN cd /var/lib && \
  curl http://mirror.ox.ac.uk/sites/rsync.apache.org//jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz -o /var/lib/jmeter-${JMETER_VERSION}.tgz && \
  tar xf jmeter-${JMETER_VERSION}.tgz && \
  rm -f jmeter-${JMETER_VERSION}.tgz && \
  ln -s /var/lib/apache-jmeter-${JMETER_VERSION} /var/lib/apache-jmeter && \
  cd ./apache-jmeter-${JMETER_VERSION} && \
  curl https://jmeter-plugins.org/files/packages/jpgc-casutg-2.1.zip -o ctg-plugin.zip && \
  unzip ctg-plugin.zip && \
  rm -f ctg-plugin.zip
