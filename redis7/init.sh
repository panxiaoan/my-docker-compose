#!/bin/sh

docker network create redis7_net

docker network ls

mkdir conf
mkdir volumes
mkdir volumes/data