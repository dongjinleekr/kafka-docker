kafka-docker (graalvm ce)
============

Dockerfile for [Apache Kafka](http://kafka.apache.org/), fork of [wurstmeister/kafka-docker](https://github.com/wurstmeister/kafka-docker).

It is **transparently replaceable** with its upstream, but based on [Oracle Linux + GraalVM CE](https://hub.docker.com/r/oracle/graalvm-ce) instead of Alphine Linux + Openjdk.

Tags and releases
-----------------

Since this project aims to create a Graalvm-equivalent for the upstream Docker image, it also follows the upstream project's tags. As of present, available tags are:

- `2.13-2.6.0`

## How to Build

```sh
export SCALA_VERSION=2.13 && export KAFKA_VERSION=2.6.0 && docker build --build-arg scala_version=${SCALA_VERSION} --build-arg kafka_version=${KAFKA_VERSION} -t dongjinleekr/kafka:${SCALA_VERSION}-${KAFKA_VERSION} .
```

