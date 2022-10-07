#!/bin/sh

self="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
# echo $self
workspace=$(dirname $(dirname $self))
# echo $workspace


cd $workspace/front-end && \
npm ci && \
npm run build

cd $workspace/back-end && \
./gradlew wrapper && \
./gradlew shadowJar

