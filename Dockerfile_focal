ARG JDKVER=17.0.6_10
FROM ubuntu:focal AS build-env
ARG TDVERSION=3.0.2.5
ARG TDVERSION_FULL=ver-${TDVERSION}

WORKDIR /tdengine

RUN apt-get update
RUN apt-get install -y tzdata
RUN apt-get install -y gcc cmake build-essential git libssl-dev
RUN apt-get install -y libjansson-dev libsnappy-dev liblzma-dev libz-dev zlib1g pkg-config

RUN git clone --depth=1 -b ${TDVERSION_FULL} https://github.com/taosdata/TDengine .
RUN git submodule update --init --recursive
RUN ./build.sh


FROM eclipse-temurin:${JDKVER}-jdk-focal
ARG TDVERSION
RUN apt-get update
RUN apt-get install -y netcat
ADD taos.cfg /etc/taos/taos.cfg
COPY --from=build-env /tdengine/debug/build/lib/libtaos.so.${TDVERSION} /usr/lib/libtaos.so.${TDVERSION}
RUN ln -s /usr/lib/libtaos.so.${TDVERSION} /usr/lib/libtaos.so
RUN ln -s /usr/lib/libtaos.so.${TDVERSION} /usr/lib/libtaos.so.1