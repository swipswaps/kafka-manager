FROM debian:stretch

ARG KAFKA_MANAGER_VERSION=1.3.3.22

ADD target/kafka-manager_${KAFKA_MANAGER_VERSION}_all.deb /tmp

RUN apt-get update && mkdir -p /usr/share/man/man1/ \
    && apt-get install --no-install-recommends -y openjdk-8-jdk-headless unzip\
    && apt-get clean && rm -rf /var/lib/apt/lists/* \
    && dpkg -i /tmp/kafka-manager_1.3.3.22_all.deb \
    && adduser --system -uid 1000 kafka-manager \
    && chmod -R 777 /usr/share/kafka-manager

EXPOSE 9000

ENV ZK_HOSTS=zookeeper:2181 \
    KAFKA_MANAGER_AUTH_ENABLED=false \
    KAFKA_MANAGER_USERNAME=admin \
    KAFKA_MANAGER_PASSWORD=password

USER 1000

CMD kafka-manager

