#!/bin/sh

if docker network inspect mynet_default >/dev/null 2>&1; then
    echo "Network 'mynet_default' already exists."
else
    echo "Creating network 'mynet_default'..."
    docker network create mynet_default
fi

mkdir conf
chmod a+x conf

mkdir ../../my-docker-volumes
mkdir ../../my-docker-volumes/redis8
mkdir ../../my-docker-volumes/redis8/data
chmod a+x ../../my-docker-volumes
chmod a+x ../../my-docker-volumes/redis8