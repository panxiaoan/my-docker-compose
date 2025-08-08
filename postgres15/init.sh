#!/bin/sh

docker network create postgres15_net

docker network ls

mkdir volumes
mkdir volumes/data