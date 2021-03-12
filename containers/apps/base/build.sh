#!/usr/bin/env bash

DOCKER_BUILDKIT=1 \
    docker build \
    --secret id=ghtoken,src=.github_token \
    --tag "apps/base:${1}" \
    --build-arg "BRANCH=${1}" \
    .
