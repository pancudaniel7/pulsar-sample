#!/bin/bash

pulsar_client_path="./bin"
tenant="public"
namespace="default"
topic_name="o1"

container_id="$(docker ps | grep apachepulsar/pulsar:2.7.1 | cut -d" " -f1)"
docker exec -it "$container_id" "$pulsar_client_path"/pulsar-client consume "$tenant/$namespace/$topic_name" -s o1-sub -n ${1:-10}