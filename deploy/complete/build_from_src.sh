#!/bin/sh

self="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
# echo $self
workspace=$(dirname $(dirname $self))
# echo $workspace

# nohup $workspace/deploy/back-only/run.sh &

# cd $workspace/back-end && \
# ./gradlew wrapper && \
# ./gradlew shadowJar

# cp $workspace/back-end/build/libs/*-shadow.jar $self/app

# cd $workspace/front-end && \
# # npm ci --cache  .npm && \
# npm run build
# # npm run preview
# # npm run dev

jar_name=$(ls $self/app | grep jar)

compose_yml=$(cat $self/docker-compose.template | sed "s|__WEB_SRC|$self/app|" | sed "s/__JAR_NAME/$jar_name/" | sed "s|__DB_INIT|$self/db-init|"| sed "s|__DIST_SRC|$workspace/front-end/dist|"| sed "s|__NGINX_CONF|$self/proxy/nginx.conf|")

# echo "$compose_yml"
echo "$compose_yml" | docker compose --file /dev/stdin up 
# echo "$compose_yml" | docker compose --file /dev/stdin rm -fsv

