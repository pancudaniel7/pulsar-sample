#!/bin/bash

pulsar_client_path="./bin"
tenant="public"
cluster="public"
namespace="default"
topic="t1"
topic2="o2"

container_id="$(docker ps | grep apachepulsar/pulsar:2.7.1 | cut -d" " -f1)"

docker exec -it "$container_id" $pulsar_client_path/pulsar-admin tenants create $tenant &&
    echo "Created tenant: $tenant"

# docker exec -it "$container_id" $pulsar_client_path/pulsar-admin namespaces create "$tenant/$namespace" &&
#     echo "Created namespace: $namespace"

docker exec -it "$container_id" $pulsar_client_path/pulsar-admin schemas upload --filename "/pulsar/data/test.avro" "$tenant/$namespace/$topic" &&
    echo "Created schema: $tenant/$namespace/$topic"
    
docker exec -it "$container_id" $pulsar_client_path/pulsar-admin schemas upload --filename "/pulsar/data/test.avro" "$tenant/$namespace/$topic" &&
    echo "Created schema: $tenant/$namespace/$topic2"