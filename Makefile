VERSION ?= 2.93
CACHE ?= --no-cache=1
FULLVERSION ?= ${VERSION}
archs = amd64 arm32v6 arm64v8 i386 ppc64le s390x

.PHONY: all build publish latest
all: build publish latest
qemu-arm-static:
	cp /usr/bin/qemu-arm-static .
qemu-aarch64-static:
	cp /usr/bin/qemu-aarch64-static .
qemu-s390x-static:
	cp /usr/bin/qemu-s390x-static .
qemu-ppc64le-static:
	cp /usr/bin/qemu-ppc64le-static .
build: qemu-aarch64-static qemu-ppc64le-static qemu-s390x-static qemu-arm-static
	$(foreach arch,$(archs), \
		cat Dockerfile | sed "s/FROM alpine/FROM ${arch}\/alpine/g" > .Dockerfile; \
		docker build -t jaymoulin/transmission:${VERSION}-$(arch) -f .Dockerfile ${CACHE} .;\
	)
publish:
	docker push jaymoulin/transmission
	cat manifest.yml | sed "s/\$$VERSION/${VERSION}/g" > manifest.yaml
	cat manifest.yaml | sed "s/\$$FULLVERSION/${FULLVERSION}/g" > manifest2.yaml
	mv manifest2.yaml manifest.yaml
	manifest-tool push from-spec manifest.yaml
latest: build
	FULLVERSION=latest VERSION=${VERSION} make publish
