#!/bin/sh

docker-compose --compatibility -f stack.yml up -d

# docker-compose -f stack.yml up -d