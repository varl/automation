FROM alpine:latest

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories
RUN apk add --no-cache \
    bash \
    git

COPY ./trigger-build/trigger-build.sh /trigger-build.sh
COPY ./repo-list.sh /repo-list.sh

RUN chmod +x /trigger-build.sh
RUN chmod +x /repo-list.sh
RUN mkdir /repos

ENTRYPOINT ["/trigger-build.sh"]
CMD ["master"]
