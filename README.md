# docker-v2ray

[![Deploy To GitHub Registry](https://github.com/CS-Tao/services/workflows/Deploy%20To%20GitHub%20Registry/badge.svg)](https://github.com/CS-Tao/services/actions?query=workflow%3A"Deploy+To+GitHub+Registry")
[![Deploy To Docker Hub](https://github.com/CS-Tao/services/workflows/Deploy%20To%20Docker%20Hub/badge.svg)](https://github.com/CS-Tao/services/actions?query=workflow%3A"Deploy+To+Docker+Hub")

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
