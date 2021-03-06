#!/bin/bash

set -e

CONFIG_FOLDER=/etc/v2ray
TMEPL_FILE=${CONFIG_FOLDER}/config.tmpl
CONFIG_FILE=${CONFIG_FOLDER}/config.json

NO_ENV_MSG="\033[31mNo REPLACEMENTS env found, use config.tmpl directly.\033[0m"
FORMAT_ERR_MSG="\033[31mREPLACEMENTS env format error.\033[0m"
DONE_MSG="\033[32mConfigured, starting...\033[0m"

initconfig () {
  [ -e ${CONFIG_FILE} ] && rm ${CONFIG_FILE}
  cp ${TMEPL_FILE} ${CONFIG_FILE}
}

initconfig

pairs=(${REPLACEMENTS//,/ })

[ -z ${REPLACEMENTS} ] && \
  echo -e ${NO_ENV_MSG} && \
  exit 0

[ ${#pairs[@]} -lt 1 ] && \
  echo -e ${FORMAT_ERR_MSG} && \
  exit 1

for pair in ${pairs[@]}
  do
    oldnew=(${pair//:/ })
    [ ${#oldnew[@]} -ne 2 ] || [ -z ${oldnew[0]} ] || [ -z ${oldnew[1]} ] && \
      echo -e ${FORMAT_ERR_MSG} && \
      initconfig && \
      exit 1
    sed -i "s/${oldnew[0]}/$(echo ${oldnew[1]})/g" ${CONFIG_FILE}
  done

echo -e ${DONE_MSG}

exec "$@"
