#!/bin/sh

docker-compose -f stack.yml up -d

# docker run \
# --name oracle18c \
# -p 15210:1521 -p 15211:5500 -p 15212:8080 \
# -e ORACLE_CHARACTERSET=AL32UTF8 \
# -v /Users/panxiaoan/work/devops/my-docker-volumes/oracle18c/data:/opt/oracle/oradata \
# container-registry.oracle.com/database/express:18.4.0-xe