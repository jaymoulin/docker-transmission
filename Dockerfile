FROM dpvduncan/rpi-alpine

RUN apk update && apk add transmission-daemon

EXPOSE 9091
EXPOSE 51413

VOLUME /data

CMD ["transmission-daemon"]
