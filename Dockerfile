ARG JDKVER=17.0.11_9-jdk-focal
FROM eclipse-temurin:${JDKVER}
ARG TDVERSION=3.3.0.3
ARG TARGETARCH

RUN apt-get update
RUN apt-get install -y netcat-traditional curl
ADD taos.cfg /etc/taos/taos.cfg

WORKDIR /tmp

RUN if [ "$TARGETARCH" = "arm64" ]; then \
    export ARCH=arm64; \
    else \
        export ARCH=x64; \
    fi && curl -o TDengine-client.tar.gz https://downloads.tdengine.com/tdengine-tsdb-oss/${TDVERSION}/tdengine-tsdb-oss-client-${TDVERSION}-linux-$ARCH.tar.gz
RUN tar -xf TDengine-client.tar.gz
RUN cd /tmp/TDengine-client-${TDVERSION} && ./install_client.sh

RUN rm -rf /tmp/TDengine-client*

WORKDIR /
