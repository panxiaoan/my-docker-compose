# My Docker Compose

https://github.com/panxiaoan/my-docker-compose

Java 开发者常用的容器：MySQL、PostgreSQL、Redis、Prometheus、Grafana...

*已准备好的容器：*

* redis
* mysql
* postgres 15、17
* oceanbase
* prometheus
* grafana
* portainer
* odoo 16、17、18
* hazelcast-management-center

*推荐 OrbStack*

OrbStack 是 macOS 中 Docker App，相比 Docker Desktop App 启动更快、资源占用更少。详情官网了解 OrbStack: https://orbstack.dev

![OrbStack](asserts/orbstack_monitor.png)

## 配置国内镜像加速服务

```shell
cat << EOF >> /etc/docker/daemon.json
{
  "registry-mirrors" : [
    "https:\/\/docker.m.daocloud.io"
  ],
  "ipv6" : false
}
EOF
```
使用 `docker info` 命令，查看是否配置成功

## 创建 Docker 默认网络

方便容器间通过统一的默认网络实现互联互通，比如示例中 Odoo ERP 连接 PostgreSQL 数据库

```shell
docker network create mynet_default
```
使用 `docker network ls` 命令，查看默认网络是否创建成功


# 相关资料
- docker 官方镜像：https://github.com/docker-library
- docker samples: https://docs.docker.com/samples/
- awesome-compose: https://github.com/docker/awesome-compose