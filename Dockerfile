FROM adoptopenjdk/openjdk8:alpine
MAINTAINER hai.vu

ENV APP_HOME=/usr/app/
WORKDIR $APP_HOME
COPY target/*.jar app.jar
# https://github.com/vishnubob/wait-for-it

RUN apk update
RUN apk add bash

# Download curl & using it to install newrelic agent
RUN apk add curl
RUN curl -O "https://download.newrelic.com/newrelic/java-agent/newrelic-agent/current/newrelic-java.zip"
RUN apk add unzip
RUN unzip -o ./newrelic-java.zip -d .
COPY newrelic.yml ./newrelic
COPY wait-for-it.sh .
COPY start.sh .
ENTRYPOINT ["./start.sh"]