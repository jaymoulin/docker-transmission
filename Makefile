VERSION ?= 0.2.0
FULLVERSION ?= ${VERSION}
archs = amd64 arm32v6 arm64v8 i386 ppc64le s390x

.PHONY: all build publish latest
all: build publish latest
build:
	cp /usr/bin/qemu-*-static .
	$(foreach arch,$(archs), \
		cat Dockerfile | sed "s/FROM alpine/FROM ${arch}\/alpine/g" > .Dockerfile; \
		docker build -t jaymoulin/transmission:${VERSION}-$(arch) -f .Dockerfile .;\
	)
publish:
	docker push jaymoulin/transmission
	cat manifest.yml | sed "s/\$$VERSION/${VERSION}/g" > manifest.yaml
	cat manifest.yaml | sed "s/\$$FULLVERSION/${FULLVERSION}/g" > manifest2.yaml
	mv manifest2.yaml manifest.yaml
	manifest-tool push from-spec manifest.yaml
latest: build
	FULLVERSION=latest VERSION=${VERSION} make publish
