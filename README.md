# docker-v2ray

v2ray 的 docker 镜像，在原官方镜像的基础上添加了模板配置文件，可在每次启动的时候通过模板配置文件和环境变量生成配置文件

[![Deploy To GitHub Registry](https://github.com/CS-Tao/docker-v2ray/workflows/Deploy%20To%20GitHub%20Registry/badge.svg)](https://github.com/CS-Tao/docker-v2ray/packages/101776?version=master)
[![Deploy To Docker Hub](https://github.com/CS-Tao/docker-v2ray/workflows/Deploy%20To%20Docker%20Hub/badge.svg)](https://hub.docker.com/r/cstao/docker-v2ray)

## 使用方法

编写配置文件模板`config.tmpl`：

```json
{
  "log" : {
    "access": "/var/log/v2ray/access.log",
    "error": "/var/log/v2ray/error.log",
    "loglevel": "warning"
  },
  "inbounds": [{
    "port": {PORT},
    "protocol": "vmess",
    "settings": {
      "clients": [
        {
          "id": "{UUID}",
          "alterId": {ALTERID},
          "level": {LEVEL},
          "email": "{EMAIL}"
        }
      ]
    }
  }],
  "outbounds": [{
    "protocol": "freedom",
    "settings": {}
  }]
}
```

启动容器：

```bash
sudo docker run -d --rm \
  --name v2ray \
  -e REPLACEMENTS={PORT}:8080,{UUID}:your_uuid,{ALTERID}:64,{LEVEL}:1,{EMAIL}:whucstao@gmail.com \
  -p 80:8080 \
  -v ./config.tmpl:/etc/v2ray/config.tmpl:ro \
  cstao/docker-v2ray:v1.0.0
```

*通过`REPLACEMENTS`规定需要替换的内容，格式为`old1:new1,old2:new2,...`*

## 其它说明

容器内默认的模板配置文件`config.tmpl`：
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
      "clients": []
    }
  }],
  "outbounds": [{
    "protocol": "freedom",
    "settings": {}
  }]
}
```

附：在线生成 uuid: [https://www.uuidgenerator.net/](https://www.uuidgenerator.net/)
