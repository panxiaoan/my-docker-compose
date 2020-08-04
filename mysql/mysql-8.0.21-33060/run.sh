#!/bin/sh


## 33060
# mkdir /Users/panxiaoan/work/docker/mysql-8.0.21-33060/data
# mkdir /Users/panxiaoan/work/docker/mysql-8.0.21-33060/conf
# mkdir /Users/panxiaoan/work/docker/mysql-8.0.21-33060/mysql-files

docker-compose -f stack-33060.yml up -d

## 33061
# mkdir /Users/panxiaoan/work/docker/mysql-8.0.21-33061/data
# mkdir /Users/panxiaoan/work/docker/mysql-8.0.21-33061/conf
# mkdir /Users/panxiaoan/work/docker/mysql-8.0.21-33061/mysql-files

docker-compose -f stack-33061.yml up -d