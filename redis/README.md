
```shell

# 查看 Redis 容器
docker ps

# 进入 Redis 控制台
docker exec -it 080c244b7d23 redis-cli

# 保存 key = value
set order 1

# 查看
get order

```