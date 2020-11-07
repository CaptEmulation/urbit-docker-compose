#!/bin/bash

set -e

DOMAIN=$1

if [ -z $DOMAIN ]
then
  echo "Usage: ./start.sh example.com"
  exit 1
fi
mkdir -p out/conf.d
envsubst '$$DOMAIN' < assets/example.com.conf > out/conf.d/$DOMAIN.conf

function toJsonArray {
    local -n array=$1
    shift
    if [ -z $1 ]
    then
      exit 0
    fi
    array+=\"$1\"
    for arg in "${@:2}"; do
        array+=",\"$arg\""
    done
}

URBIT_CMD=()
toJsonArray URBIT_CMD ${@:2}
URBIT_CMD=$URBIT_CMD envsubst '$$URBIT_CMD' < assets/docker-compose.yaml > out/docker-compose.yaml
cd out

docker-compose up
