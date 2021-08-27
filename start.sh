#!/bin/sh

# Dnewrelic.config will override config in newrelic.yml file
# For more information: https://docs.newrelic.com/docs/agents/java-agent/configuration/java-agent-configuration-config-file/
# "./wait-for-it.sh","oracle-db:1521","--timeout=0","--strict", "--", \
java -javaagent:/usr/app/newrelic/newrelic.jar \
    -Dnewrelic.config.app_name="$SERVICE_NAME" \
    -Dnewrelic.config.environment="$SERVICE_ENVIRONMENT" \
    -jar app.jar