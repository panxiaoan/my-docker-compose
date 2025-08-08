# Redis

## Redis 官方镜像
- https://github.com/docker-library/docs/blob/master/redis/README.md
- 官方安装文档：https://redis.io/docs/install/install-redis/install-redis-on-mac-os/

## 使用方法

```shell

# 查看 Redis 容器
docker ps

# 进入 Redis 控制台
docker exec -it redis redis-cli

# 保存 key = value
set order 1

# 查看
get order

```