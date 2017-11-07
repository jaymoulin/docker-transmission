![logo](logo.png)

Raspberry PI - Transmission Bittorrent Client - Docker Image
===

[![latest release](https://img.shields.io/github/release/jaymoulin/docker-rpi-transmission.svg "latest release")](http://github.com/jaymoulin/docker-rpi-transmission/releases)
[![Docker Pulls](https://img.shields.io/docker/pulls/jaymoulin/rpi-transmission.svg)](https://hub.docker.com/r/jaymoulin/rpi-transmission/)
[![Docker stars](https://img.shields.io/docker/stars/jaymoulin/rpi-transmission.svg)](https://hub.docker.com/r/jaymoulin/rpi-transmission/)
[![Bitcoin donation](https://github.com/jaymoulin/jaymoulin.github.io/raw/master/btc.png "Bitcoin donation")](https://m.freewallet.org/id/374ad82e/btc)
[![Litecoin donation](https://github.com/jaymoulin/jaymoulin.github.io/raw/master/ltc.png "Litecoin donation")](https://m.freewallet.org/id/374ad82e/ltc)

This image allows you to run an headless Bittorrent client on your Raspberry PI easily thanks to Docker.

Installation
---

This will start Transmission
```
docker run -d --restart=always --name transmission -v /path/to/incoming/torrents:/to_download -v /path/to/downloaded/files:/output -p 9091:9091 -p 51413:51413 -p 51413:51413/udp -e USERNAME=admin -p PASSWORD=admin jaymoulin/rpi-transmission
```

### Volumes

* Mount a volume to `/to_download` folder so you can put .torrent files in to be downloaded
* Mount a volume to `/output` folder to retrieve your downloaded files

### Ports

* 9091 is the port for web interface. You can go to http://__raspberry_ip__:9091 to display interface
* 51413 and 51413/udp are the port for torrents

### Variables

* You can configure your credentials by defining `USERNAME` and `PASSWORD` environment variables. Default credentials are Login : "admin" / Password : "admin". Please change them for security reasons


Updating
---

When Transmission new version is released, you will be able to update your running version with this command:
 
```
docker exec transmission apk upgrade --update --no-cache transmission-daemon && docker restart transmission
```

Appendixes
---

### Install RaspberryPi Docker

If you don't have Docker installed yet, you can do it easily in one line using this command
 
```
curl -sSL "https://gist.githubusercontent.com/jaymoulin/e749a189511cd965f45919f2f99e45f3/raw/0e650b38fde684c4ac534b254099d6d5543375f1/ARM%2520(Raspberry%2520PI)%2520Docker%2520Install" | sudo sh && sudo usermod -aG docker $USER
```

