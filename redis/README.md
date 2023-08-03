
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