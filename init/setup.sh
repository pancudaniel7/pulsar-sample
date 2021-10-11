#!/bin/bash

pulsar_client_path="./bin"
tenant="test"
cluster="test1"
namespace="namespace1"
topic="topic1"

container_id="$(docker ps | grep apachepulsar/pulsar:2.7.0 | cut -d" " -f1)" &&
    docker exec -it "$container_id" $pulsar_client_path/pulsar-admin tenants create $tenant &&
    echo "Created tenant: $tenant"

docker exec -it "$container_id" $pulsar_client_path/pulsar-admin namespaces create "$tenant/$namespace" &&
    echo "Created namespace: $namespace"

docker exec -it "$container_id" $pulsar_client_path/pulsar-admin topics create-missed-partitions persistent://$tenant/$namespace/$topic &&
    echo "Created topic $topic"

docker exec -it "$container_id" $pulsar_client_path/pulsar-admin schemas upload --filename "/pulsar/data/test.avro" "$tenant/$namespace/$topic" &&
    echo "Created schema: $tenant/$namespace/$topic"