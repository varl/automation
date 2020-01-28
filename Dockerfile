FROM alpine:latest

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories
RUN apk add --no-cache \
    bash \
    hub \
    git

COPY /merge-translations.sh /merge-translations.sh
COPY /repo-list.sh /repo-list.sh

RUN chmod +x /merge-translations.sh
RUN chmod +x /repo-list.sh
RUN mkdir /repos

ENTRYPOINT ["/merge-translations.sh"]
CMD ["master"]
