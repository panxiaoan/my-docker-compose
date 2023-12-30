#!/bin/sh

docker network create postgres14_net

docker network ls

mkdir volumes
mkdir volumes/data