.PHONY: all
all: deb-bin docker-image publish-docker-hub

MAJOR_VERSION := 1.3.3
MINOR_VERSION := 22

.PHONY: deb-bin
deb-bin:
	./sbt debian:packageBin

.PHONY: docker-image
docker-image:
	docker build -t syscomiddleware/kafka-manager:${MAJOR_VERSION} .
	docker build -t syscomiddleware/kafka-manager:${MAJOR_VERSION}.${MINOR_VERSION} .

.PHONY: publish-docker-hub
publish-docker-hub:
	docker push syscomiddleware/kafka-manager:${MAJOR_VERSION}
	docker push syscomiddleware/kafka-manager:${MAJOR_VERSION}.${MINOR_VERSION}