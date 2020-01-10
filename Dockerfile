FROM v2ray/official:latest

RUN apk update \
  && apk upgrade \
  && apk add --no-cache bash \
  ossp-uuid-dev \
  && rm -rf /var/cache/apk/*

COPY config.tmpl /etc/v2ray/config.tmpl
COPY entrypoint.sh /etc/v2ray/entrypoint.sh

RUN chmod +x /etc/v2ray/entrypoint.sh

WORKDIR /etc/v2ray/

ENTRYPOINT ["./entrypoint.sh"]

CMD ["v2ray", "-config=/etc/v2ray/config.json"]
