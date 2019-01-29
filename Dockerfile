FROM debian:stretch-slim

ADD target/kafka-manager_1.3.3.22_all.deb /tmp

RUN apt-get update && mkdir -p /usr/share/man/man1/ \
    && apt-get install --no-install-recommends -y openjdk-8-jdk-headless unzip\
    && apt-get clean && rm -rf /var/lib/apt/lists/* \
    && dpkg -i /tmp/kafka-manager_1.3.3.22_all.deb

EXPOSE 9090

ENV ZK_HOSTS=zookeeper:2181 \
    KAFKA_MANAGER_AUTH_ENABLED=false \
    KAFKA_MANAGER_USERNAME=admin \
    KAFKA_MANAGER_PASSWORD=password

CMD kafka-manager

