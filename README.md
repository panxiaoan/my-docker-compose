# My Docker Compose

https://github.com/panxiaoan/my-docker-compose

我本地开发环境常用的 Docker Compose，例如：MySQL、Postgres、Redis、Mycat、Prometheus、Grafana...

如果使用 macOS 建议使用 OrbStack App，相比 Docker Desktop 启动更快、资源占用更少
- OrbStack: https://orbstack.dev

# 配置国内镜像加速服务

```shell
cat << EOF >> /etc/docker/daemon.json
{
  "debug": true,
  "experimental": true,
  "registry-mirrors": [
		"https://registry.cn-hangzhou.aliyuncs.com",
		"http://hub-mirror.c.163.com",
		"https://registry.docker-cn.com",
		"https://docker.mirrors.ustc.edu.cn"
	]
}
EOF
```
使用 `docker info` 命令，查看是否配置成功

# 创建 Docker 默认网络

方便容器间通过统一的默认网络实现互联互通，比如示例中 Odoo ERP 连接 PostgreSQL 数据库

```shell
docker network create mynet_default
```
使用 `docker network ls` 命令，查看默认网络是否创建成功


# 相关资料
- docker 官方镜像：https://github.com/docker-library
- docker samples: https://docs.docker.com/samples/
- awesome-compose: https://github.com/docker/awesome-compose/tree/master/nginx-nodejs-redis