#!/bin/bash

# https://stackoverflow.com/questions/4774054/reliable-way-for-a-bash-script-to-get-the-full-path-to-itself
self="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

jar_name=$(ls $self/app | grep jar)

compose_yml=$(cat $self/docker-compose.template | sed "s|__WEB_SRC|$self/app|" | sed "s/__JAR_NAME/$jar_name/" | sed "s|__DB_INIT|$self/db-init|")

echo "$compose_yml" | docker compose --file /dev/stdin up
echo "$compose_yml" | docker compose --file /dev/stdin rm -fsv
