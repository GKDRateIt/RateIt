#!/bin/bash

# https://stackoverflow.com/questions/4774054/reliable-way-for-a-bash-script-to-get-the-full-path-to-itself
self="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
workspace=$(dirname $(dirname $self))

pushd $workspace/back-end 


./gradlew wrapper && \
./gradlew shadowJar

popd

cp $workspace/back-end/build/libs/*-shadow.jar $self/app

jar_name=$(ls $self/app | grep jar)

compose_yml=$(cat $self/docker-compose.template | sed "s|__WEB_SRC|$self/app|" | sed "s/__JAR_NAME/$jar_name/" | sed "s|__DB_INIT|$self/db-init|"| sed "s|__NGINX_CONF|$self/proxy/nginx.conf|")

echo "$compose_yml" | docker compose --file /dev/stdin up
echo "$compose_yml" | docker compose --file /dev/stdin rm -fsv

#   nginx:
#     image: nginx
#     volumes:
#       - type: bind
#         source: __NGINX_CONF
#         target: /etc/nginx/
#     command: [ "nginx" ]

#   web:
#     image: openjdk:17-slim-bullseye
#     ports:
#       - "8080:8080"
#     depends_on:
#       - database
#     working_dir: /app
#     volumes:
#       - type: bind
#         source: __WEB_SRC
#         target: /app
#     command: [ "java", "-jar", "__JAR_NAME" ]