FROM alpine as builder

COPY qemu-*-static /usr/bin/

FROM builder

LABEL maintainer="Jay MOULIN <jaymoulin@gmail.com> <https://twitter.com/MoulinJay>"

RUN apk update --no-cache && apk add transmission-daemon
WORKDIR /usr/bin

EXPOSE 9091
EXPOSE 51413
EXPOSE 51413/udp

VOLUME /output
VOLUME /to_download

ENV USERNAME=admin
ENV PASSWORD=admin

CMD transmission-daemon -c /to_download -w /output -f -t -a *.*.*.* -u "$USERNAME" -v "$PASSWORD"
