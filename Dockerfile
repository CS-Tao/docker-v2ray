FROM v2ray/official:latest

COPY config.tmpl /etc/v2ray/config.tmpl
COPY entrypoint.sh ./entrypoint.sh

RUN chmod +x ./entrypoint.sh

ENTRYPOINT ['./entrypoint.sh']

CMD ["v2ray", "-config=/etc/v2ray/config.json"]
