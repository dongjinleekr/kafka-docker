FROM oracle/graalvm-ce:20.3.0-java8

ARG kafka_version=2.7.0
ARG scala_version=2.13

LABEL org.label-schema.name="kafka" \
      org.label-schema.description="Apache Kafka" \
      org.label-schema.build-date="${build_date}" \
      org.label-schema.vcs-url="https://github.com/dongjinleekr/kafka-docker" \
      org.label-schema.vcs-ref="${vcs_ref}" \
      org.label-schema.version="${scala_version}_${kafka_version}" \
      org.label-schema.schema-version="1.0" \
      maintainer="dongjin@apache.org"

ENV KAFKA_VERSION=$kafka_version
ENV SCALA_VERSION=$scala_version
ENV KAFKA_HOME=/opt/kafka
ENV PATH=${PATH}:${KAFKA_HOME}/bin

# NOTE If you prefer downloading the official release instead of copying the built package,
# comment out the method 2 and uncomment method 1.

# Method 1 start: Download the official release.
# COPY download-kafka.sh versions.sh start-kafka.sh create-topics.sh /tmp/

# curl, jq, wget: download-kafka.sh
# hostname, docker: start-kafka.sh
# RUN yum install -y curl jq wget hostname docker \
#  && chmod a+x /tmp/*.sh \
#  && mv /tmp/start-kafka.sh /tmp/create-topics.sh /tmp/versions.sh /usr/bin \
#  && sync && /tmp/download-kafka.sh \
#  && tar xfz /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -C /opt \
#  && rm /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz \
#  && ln -s /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION} ${KAFKA_HOME} \
#  && rm /tmp/*
# Method 1 end

# Method 2 start: Copy built package directly. This approach is useful when you are building a custom release.
COPY start-kafka.sh create-topics.sh /tmp/

COPY kafka_${SCALA_VERSION}-${KAFKA_VERSION} /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION}

RUN yum install -y hostname docker \
 && chmod a+x /tmp/*.sh \
 && mv /tmp/start-kafka.sh /tmp/create-topics.sh /usr/bin \
 && sync \
 && ln -s /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION} ${KAFKA_HOME}
# Method 2 end

VOLUME ["/kafka"]

# Use "exec" form so that it runs as PID 1 (useful for graceful shutdown)
CMD ["start-kafka.sh"]
