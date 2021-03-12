#!/usr/bin/env bash

gh repo clone varl/layland

pushd layland
npm install

./bin/layland generate \
    "/root/repos/apps/**/*/package.json" \
    > layoftheland.md

pandoc --from markdown \
       --to html \
       --output "apps-${1}.html" \
       --metadata title="Lay of the Land: ${1}" \
       --self-contained \
       --toc \
       --css pandoc.css \
       layoftheland.md
popd

cp "layland/apps-${1}.html" /srv/index.html
