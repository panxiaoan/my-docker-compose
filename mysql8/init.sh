#!/bin/sh

if docker network inspect docker_default_net >/dev/null 2>&1; then
    echo "Network 'docker_default_net' already exists."
else
    echo "Creating network 'docker_default_net'..."
    docker network create docker_default_net
fi

mkdir ../../my-docker-volumes
mkdir ../../my-docker-volumes/mysql8
mkdir ../../my-docker-volumes/mysql8/data
mkdir ../../my-docker-volumes/mysql8/conf
mkdir ../../my-docker-volumes/mysql8/mysql-files
chmod a+x ../../my-docker-volumes
chmod a+x ../../my-docker-volumes/mysql8