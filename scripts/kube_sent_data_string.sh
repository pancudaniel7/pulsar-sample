#!/bin/bash

pulsar_client_path="./bin"
tenant="public"
namespace="default"

container_id="$(kubectl get pods | grep toolset | cut -d" " -f1)"

function sent_data() {
  limit=${1:-4}
  for ((i = 0; i < $limit; i++)); do
    topic_suffix_index=$((i % 4))
    topic_suffix=${topics_suffix[topic_suffix_index]}

    topic_name="${2:-t1}"
    kubectl exec -it "$container_id" "$pulsar_client_path"/pulsar-client produce "$tenant/$namespace/$topic_name" \
      -m "Test message <----<"
      -n 1 &&
    echo "Sent: $((i + 1)) to $topic_name"
  done
}

sent_data ${1:-1} t1