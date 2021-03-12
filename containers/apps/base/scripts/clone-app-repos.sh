#!/usr/bin/env bash

mkdir -p "repos/apps/${1}"
pushd repos/apps

while IFS= read -r line; do
    gh repo clone "$line" -- --depth 1 --branch "$1"
done
