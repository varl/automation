# syntax = docker/dockerfile:1.0-experimental
FROM debian:buster-slim AS base
ARG BRANCH=master

RUN apt-get update \
    && apt-get install -y curl gnupg openssh-client software-properties-common

RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -
RUN echo "deb https://deb.nodesource.com/node_15.x buster main" | tee /etc/apt/sources.list.d/nodesource.list
RUN echo "deb-src https://deb.nodesource.com/node_15.x buster main" | tee -a /etc/apt/sources.list.d/nodesource.list

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
RUN apt-add-repository https://cli.github.com/packages

RUN apt-get update \
    && apt-get install -y git gh myrepos nodejs pandoc tree

RUN npm install -g yarn

WORKDIR /root/
COPY ./scripts scripts/

RUN --mount=type=secret,id=ghtoken gh auth login --with-token < /run/secrets/ghtoken

RUN scripts/list-app-repos.sh > app-list
RUN scripts/clone-app-repos.sh "$BRANCH" < app-list

FROM base

WORKDIR /root/

CMD ["tree", "-L", "3", "/root"]
