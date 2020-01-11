# docker-v2ray

v2ray 的 docker 镜像，在原官方镜像的基础上添加了模板配置文件，可在每次启动的时候通过模板配置文件和环境变量生成配置文件，以更方便地设置 client 的 uuid

[![Deploy To GitHub Registry](https://github.com/CS-Tao/docker-v2ray/workflows/Deploy%20To%20GitHub%20Registry/badge.svg)](https://github.com/CS-Tao/docker-v2ray/packages/101776?version=master)
[![Deploy To Docker Hub](https://github.com/CS-Tao/docker-v2ray/workflows/Deploy%20To%20Docker%20Hub/badge.svg)](https://hub.docker.com/r/cstao/docker-v2ray)

## 使用方法

在线生成 uuid: [https://www.uuidgenerator.net/](https://www.uuidgenerator.net/)

```bash
sudo docker run -d --rm \
  --name v2ray \
  -e CLIENTS_IDS=uuid1,uuid2,uuid3 \
  -e CLIENTS_LEVELS=1,1,2 \
  -e CLIENTS_ALTERIDS=64,64,32 \
  -e CLIENTS_EMAILS=email1,email2,email3 \
  -p 80:8080 \
  -v ./config.tmpl:/etc/v2ray/config.tmpl:ro \
  docker.pkg.github.com/cs-tao/docker-v2ray/docker-v2ray:master
```

## 环境变量说明

**CLIENTS_IDS**: uuid，用于用户认证，不同用户用逗号隔开，不能有空格。未设置此变量时系统会自动生成一个 uuid，可在容器启动后运行`docker logs v2ray`查看

**CLIENTS_LEVELS**: 针对每个 uuid 的 level，不同值用逗号隔开，不能有空格。level 的个数应和 uuid 的个数保持一致，缺少则会使用默认值(1)

**CLIENTS_ALTERIDS**: 针对每个 uuid 的 alterId，不同值用逗号隔开，不能有空格。alterId 的个数应和 uuid 的个数保持一致，缺少则会使用默认值(64)

**CLIENTS_EMAILS**: 针对每个 uuid 的 alterId，不同值用逗号隔开，不能有空格。email 的个数应和 uuid 的个数保持一致，缺少则会使用默认值(nobody@email.com)

## 模板配置文件示例 (镜像默认的模板配置文件)

容器每次启动的时候会通过环境变量生成配置文件所需的 clients 字段，然后替换掉模板配置文件中所有的`{CLIENTS_TEMPLATE}`字符串

```json
{
  "log" : {
    "access": "/var/log/v2ray/access.log",
    "error": "/var/log/v2ray/error.log",
    "loglevel": "warning"
  },
  "inbounds": [{
    "port": 8080,
    "protocol": "vmess",
    "settings": {
      "clients": [{CLIENTS_TEMPLATE}]
    }
  }],
  "outbounds": [{
    "protocol": "freedom",
    "settings": {}
  }]
}
```
