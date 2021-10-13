#!/bin/bash

pulsar_client_path="./bin"
tenant="test"
namespace="namespace1"
topic="topic1"

container_id="$(docker ps | grep apachepulsar/pulsar:2.7.1 | cut -d" " -f1)"

function sent_data() {
  limit=${1:-4}
  for ((i = 0; i < $limit; i++)); do
    topic_suffix_index=$((i % 4))
    topic_suffix=${topics_suffix[topic_suffix_index]}

    topic_name="${2:-topic1}"
    docker exec -it "$container_id" "$pulsar_client_path"/pulsar-client produce "$tenant/$namespace/$topic" -m \
      "\"customerNumber\":\"100$i\"" \
      -n 1
    echo "Sent: $((i + 1)) to $topic_name"
  done
}

sent_data 4 topic1