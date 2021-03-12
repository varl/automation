# syntax = docker/dockerfile:1.0-experimental
ARG BRANCH=master
FROM apps/base:${BRANCH}
ARG BRANCH

WORKDIR /root/
COPY ./scripts scripts/

RUN scripts/generate-layoftheland.sh "$BRANCH"

CMD ["cat", "/srv/index.html"]
