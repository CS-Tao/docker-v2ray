#!/bin/sh

default_level=1
default_alterid=64
default_email=nobody@email.com

CONFIG_FOLDER=/etc/v2ray
TMEPL_FILE=${CONFIG_FOLDER}/config.tmpl
CONFIG_FILE=${CONFIG_FOLDER}/config.json

[ -e ${CONFIG_FILE} ] && rm ${CONFIG_FILE}

client_ids=(${CLIENTS_IDS//,/ })
levels=(${CLIENTS_LEVELS//,/ })
alters_ids=(${CLIENTS_ALTERIDS//,/ })
emails=(${CLIENTS_EMAILS//,/ })

clients=""
if [[ -z client_ids[0] ]]; then
  index=0
  for id in ${client_ids[@]}
    do
      [ -z ${levels[${index}]} ] && \
        level=${default_level} && \
        echo "Level for client(${id}) not found. Use default Level: ${default_level}" || \
        level=${levels[${index}]}
      [ -z ${alters_ids[${index}]} ] && \
        alterId=${default_alterid} && \
        echo "AlterId for client(${id}) not found. Use default alter id: ${default_alterid}" || \
        alterId=${alters_ids[${index}]}
      [ -z ${emails[${index}]} ] && \
        email=${default_email} && \
        echo "Email for client(${id}) not found. Use default email: ${default_email}" || \
        email=${emails[${index}]}

      client="
      {
        \"id\": \"$id\",
        \"level\": ${level},
        \"alterId\": ${alterId},
        \"email\": \"${email}\"
      }
      "
      [[ ${index} -eq 0 ]] && clients=${client} || clients=${clients},${client}

      index=$(expr $index + 1)
    done
else
  client_id=uuid=$(uuidgen)
  clients="
  {
    \"id\": \"${client_id}\",
    \"level\": ${default_level},
    \"alterId\": ${default_alterid},
    \"email\": \"${default_email}\"
  }
  "
  echo "No client id found. Use default client id: ${client_id}"
  echo "Level is: ${default_level}"
  echo "AlterId is: ${default_alterid}"
  echo "Email is: ${default_email}"
fi

cp ${TMEPL_FILE} ${CONFIG_FILE}

sed -i "s/{CLIENTS_TEMPLATE}/$(echo ${clients})/g" ${CONFIG_FILE}

echo "Configured, starting..."

exec "$@"
