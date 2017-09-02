FROM dpvduncan/rpi-alpine

RUN apk update --no-cache && apk add transmission-daemon

EXPOSE 9091
EXPOSE 51413

VOLUME /output
VOLUME /to_download

ENV USERNAME=admin
ENV PASSWORD=admin

CMD ["/usr/bin/transmission-daemon", "-c", "/to_download", "-w", "/output", "-f", "-t", "-u", "${USERNAME}", "-v", "${PASSWORD}"]
