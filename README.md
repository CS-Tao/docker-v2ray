# docker-v2ray

v2ray 的 docker 镜像，在原官方镜像的基础上添加了模板配置文件，可在每次启动的时候通过模板配置和环境变量生成配置文件，以更方便地设置 client 的 uuid

[![Deploy To GitHub Registry](https://github.com/CS-Tao/docker-v2ray/workflows/Deploy%20To%20GitHub%20Registry/badge.svg)](https://github.com/CS-Tao/docker-v2ray/packages/101776?version=master)
[![Deploy To Docker Hub](https://github.com/CS-Tao/docker-v2ray/workflows/Deploy%20To%20Docker%20Hub/badge.svg)](https://hub.docker.com/r/cstao/docker-v2ray)

```bash
sudo docker run -d --rm \
  --name v2ray \
  -e V2RAY_CLIENTS_IDS=uuid1,uuid2,uuid3 \
  -e V2RAY_CLIENTS_LEVELS=1,1,2 \
  -e V2RAY_CLIENTS_ALTERIDS=64,64,32 \
  -e V2RAY_CLIENTS_EMAILS=email1,email2,email3 \
  -p 80:8080 \
  -v ./config.tmpl:config.tmpl:ro
  docker.pkg.github.com/cs-tao/docker-v2ray/docker-v2ray:master
```
