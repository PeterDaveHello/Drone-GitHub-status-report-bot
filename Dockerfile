FROM alpine:3.5
MAINTAINER Peter Dave Hello <hsu@peterdavehello.org>
ADD main.sh /
RUN apk -U upgrade && \
    apk -v add curl openssl && \
    rm -rf /var/cache/apk/*
ENTRYPOINT /main.sh
