.PHONY: all
all: deb-bin docker-image publish-docker-hub

MAJOR_VERSION := 1.3.3
MINOR_VERSION := 22
DOCKER_HUB_ORG := syscomiddleware

.PHONY: deb-bin
deb-bin:
	./sbt debian:packageBin

.PHONY: docker-image
docker-image:
	docker build -t ${DOCKER_HUB_ORG}/kafka-manager:${MAJOR_VERSION} . --build-arg KAFKA_MANAGER_VERSION=${MAJOR_VERSION}.${MINOR_VERSION}

.PHONY: publish-docker-hub
publish-docker-hub:
	docker push ${DOCKER_HUB_ORG}/kafka-manager:${MAJOR_VERSION}
	docker tag ${DOCKER_HUB_ORG}/kafka-manager:${MAJOR_VERSION} syscomiddleware/kafka-manager:${MAJOR_VERSION}.${MINOR_VERSION}
	docker push ${DOCKER_HUB_ORG}/kafka-manager:${MAJOR_VERSION}.${MINOR_VERSION}