#!/bin/bash

# 1. 先清除可能已存在的 hello-world（避免干扰测试）
docker rm -f $(docker ps -aq -f "name=hello-world") 2>/dev/null || true
docker rmi hello-world 2>/dev/null || true

# 2. 运行测试命令（自动拉取并运行）
docker run hello-world

# 3. 如果输出如下结果，说明 Docker 可以正常拉取镜像

# Hello from Docker!
# This message shows that your installation appears to be working correctly.

# To generate this message, Docker took the following steps:
#  1. The Docker client contacted the Docker daemon.
#  2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
#     (arm64v8)
#  3. The Docker daemon created a new container from that image which runs the
#     executable that produces the output you are currently reading.
#  4. The Docker daemon streamed that output to the Docker client, which sent it
#     to your terminal.

# To try something more ambitious, you can run an Ubuntu container with:
#  $ docker run -it ubuntu bash

# Share images, automate workflows, and more with a free Docker ID:
#  https://hub.docker.com/

# For more examples and ideas, visit:
#  https://docs.docker.com/get-started/