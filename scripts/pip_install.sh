#!/bin/bash

python_lib_name="python-pulsar-extended-logger"
container_id="$(docker ps | grep apachepulsar/pulsar:2.7.1 | cut -d" " -f1)"

whl_file_name=$(docker exec -it "$container_id" /bin/ls "/tmp/$python_lib_name/dist/" | grep whl | head -1)

docker exec -it "$container_id" /usr/local/bin/pip uninstall "$python_lib_name" -y
docker exec -it "$container_id" /usr/local/bin/pip install "/tmp/$python_lib_name/dist/$whl_file_name"