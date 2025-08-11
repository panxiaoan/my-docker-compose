#!/bin/sh

if docker network inspect mynet_default >/dev/null 2>&1; then
    echo "Network 'mynet_default' already exists."
else
    echo "Creating network 'mynet_default'..."
    docker network create mynet_default
fi

mkdir ../../docker-volumes
mkdir ../../docker-volumes/odoo18
mkdir ../../docker-volumes/odoo18/data
mkdir ../../docker-volumes/odoo18/addons

chmod a+x ../../docker-volumes/odoo18

mkdir conf
chmod a+x conf