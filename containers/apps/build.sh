#!/usr/bin/env bash

mkdir -p out

array=( "master" )

for i in "${array[@]}"
do
    pushd base
    . build.sh "$i"
    popd

    pushd layland
    . build.sh "$i"
    popd

    docker run "apps/layland:$i" > "out/apps-${i}-$(date +'%Y%m%d').html"
done
