FROM alpine as builder

COPY qemu-aarch64-static /usr/bin/
COPY qemu-arm-static /usr/bin/
COPY qemu-s390x-static /usr/bin/
COPY qemu-ppc64le-static /usr/bin/

FROM builder

LABEL maintainer="Jay MOULIN <jaymoulin@gmail.com> <https://twitter.com/MoulinJay>"

RUN echo "http://dl-4.alpinelinux.org/alpine/edge/main/" >> /etc/apk/repositories && \ 
apk update --no-cache && \
apk add transmission-daemon
WORKDIR /usr/bin

EXPOSE 9091
EXPOSE 51413
EXPOSE 51413/udp

VOLUME /output
VOLUME /to_download

ENV USERNAME=admin
ENV PASSWORD=admin

CMD transmission-daemon -c /to_download -w /output -f -t -a *.*.*.* -u "$USERNAME" -v "$PASSWORD"
