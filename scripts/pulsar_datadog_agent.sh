#!/bin/bash

container_id=$(docker ps | grep -i agent:7 | cut -d" " -f1)

docker cp ../build/datadog_pulsar-0.0.1-py2.py3-none-any.whl $container_id:/tmp/datadog_pulsar-0.0.1-py2.py3-none-any.whl &&
docker exec $container_id /opt/datadog-agent/bin/agent/agent integration install --allow-root -w /tmp/datadog_pulsar-0.0.1-py2.py3-none-any.whl &&
docker exec $container_id /bin/mv /etc/datadog-agent/conf.d/pulsar.d/conf.yaml.example /etc/datadog-agent/conf.d/pulsar.d/conf.yaml
# WIP...