#!/bin/sh

if docker network inspect docker_default_net >/dev/null 2>&1; then
    echo "Network 'docker_default_net' already exists."
else
    echo "Creating network 'docker_default_net'..."
    docker network create docker_default_net
fi

mkdir ../../my-docker-volumes
mkdir ../../my-docker-volumes/postgres18
mkdir ../../my-docker-volumes/postgres18/data
chmod a+x ../../my-docker-volumes
chmod a+x ../../my-docker-volumes/postgres18