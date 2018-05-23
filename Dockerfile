FROM jenkins/jenkins:2.71-alpine

ENV JENKINS_REF /usr/share/jenkins/ref

ENV STRESS_VERSION=1.0.4 \
    SHELL=/bin/bash

USER root

RUN apk add --update \
    python \
    python-dev \
    py-pip \
    build-base \
    tar zip unzip \
  && curl -o /tmp/stress-${STRESS_VERSION}.tgz https://people.seas.harvard.edu/~apw/stress/stress-${STRESS_VERSION}.tar.gz \
  && cd /tmp && tar xvf stress-${STRESS_VERSION}.tgz && rm /tmp/stress-${STRESS_VERSION}.tgz \
  && cd /tmp/stress-${STRESS_VERSION} \
  && ./configure && make && make install \
  && pip install virtualenv \
  && pip install --upgrade pip setuptools \
  && pip install awscli \
  && rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/*

# install jenkins plugins
COPY jenkins-home/plugins.txt $JENKINS_REF/
RUN /usr/local/bin/plugins.sh $JENKINS_REF/plugins.txt

ENV JAVA_OPTS -Dorg.eclipse.jetty.server.Request.maxFormContentSize=100000000 \
 			  -Dorg.apache.commons.jelly.tags.fmt.timeZone=America/Los_Angeles \
 			  -Dhudson.diyChunking=false \
 			  -Djenkins.install.runSetupWizard=false

# copy scripts and ressource files
COPY jenkins-home/*.* $JENKINS_REF/
COPY jenkins-home/jobs $JENKINS_REF/jobs/
COPY jenkins-home/init.groovy.d $JENKINS_REF/init.groovy.d/
COPY jenkins-home/dsl $JENKINS_REF/dsl/
