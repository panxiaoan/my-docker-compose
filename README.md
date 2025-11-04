# [My Docker Compose](https://github.com/panxiaoan/my-docker-compose)

Java 开发者常用的容器：MySQL、PostgreSQL、Redis、Prometheus、Grafana...

*已准备好的容器：*

* redis
* mysql
* postgres
* oceanbase
* prometheus
* grafana
* portainer
* odoo erp
* aos erp(axelor open suite)
* hazelcast-management-center

*推荐 macOS 用户使用 Docker 客户端 OrbStack*

OrbStack 是 macOS 中 Docker App，相比 Docker Desktop App 启动更快、资源占用更少。详情见 [OrbStack 官网](https://orbstack.dev)

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
- [docker 官方镜像](https://github.com/docker-library)
- [docker samples](https://docs.docker.com/samples/)
- [awesome-compose](https://github.com/docker/awesome-compose)
- [国内镜像加速器](https://gist.github.com/y0ngb1n/7e8f16af3242c7815e7ca2f0833d3ea6)
- [注册华为云，使用专属镜像加速](https://console.huaweicloud.com/swr/?region=cn-north-4#/swr/mirror)