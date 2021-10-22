#!/bin/bash

container_id="$(docker ps | grep apachepulsar/pulsar:2.7.1 | cut -d" " -f1)"

tenant="public"
namespace="default"
topic="t1"
topic2="o2"
log_topic="l1"
function_name="FirstFunction"
module_name="first"

docker exec -it $container_id ./bin/pulsar-admin functions create \
    --py /tmp/pulsar/functions/$module_name.py \
    --classname $module_name.$function_name \
    --tenant $tenant \
    --namespace $namespace \
    --log-topic persistent://$tenant/$namespace/$log_topic \
    --inputs persistent://$tenant/$namespace/$topic \
    --output persistent://$tenant/$namespace/$topic2

docker exec -it $container_id ./bin/pulsar-admin functions status \
    --tenant $tenant \
    --namespace $namespace \
    --name $function_name

# docker exec -it $container_id ./bin/pulsar-admin functions trigger \
#   --tenant test \
#   --namespace namespace1 \
#   --name TestFunction \
#   --topic persistent://$tenant/$namespace/testTopic1 \
#   --triger-value "Test"