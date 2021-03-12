#!/usr/bin/env bash

echo "Building branch: ${1}"

DOCKER_BUILDKIT=1 \
    docker build \
    --tag "apps/layland:${1}" \
    --build-arg "BRANCH=${1}" \
    .
