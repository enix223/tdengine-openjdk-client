ARG JDKVER=17.0.11_9-jdk-focal
FROM eclipse-temurin:${JDKVER}
ARG TDVERSION=3.3.0.3
ARG TARGETARCH

RUN apt-get update
RUN apt-get install -y netcat-traditional
ADD taos.cfg /etc/taos/taos.cfg

WORKDIR /tmp

RUN if [ "$TARGETARCH" = "arm64" ]; then \
    export ARCH=arm64; \
    else \
        export ARCH=x64; \
    fi && curl -o tdengine.tar.gz https://www.tdengine.com/assets-download/3.0/TDengine-client-${TDVERSION}-Linux-$ARCH.tar.gz
RUN tar -xf tdengine.tar.gz
RUN cp TDengine-client-${TDVERSION}/driver/libtaos.so.${TDVERSION} /usr/lib/
RUN cp TDengine-client-${TDVERSION}/driver/libtaosnative.so.${TDVERSION} /usr/lib/
RUN cp TDengine-client-${TDVERSION}/driver/libtaosws.so.${TDVERSION} /usr/lib/

RUN ln -s /usr/lib/libtaos.so.${TDVERSION} /usr/lib/libtaos.so
RUN ln -s /usr/lib/libtaos.so.${TDVERSION} /usr/lib/libtaos.so.1
RUN ln -s /usr/lib/libtaosnative.so.${TDVERSION} /usr/lib/libtaosnative.so
RUN ln -s /usr/lib/libtaosnative.so.${TDVERSION} /usr/lib/libtaosnative.so.1
RUN ln -s /usr/lib/libtaosws.so.${TDVERSION} /usr/lib/libtaosws.so
RUN ln -s /usr/lib/libtaosws.so.${TDVERSION} /usr/lib/libtaosws.so.1

RUN rm -rf /tmp/TDengine-client-*

WORKDIR /
