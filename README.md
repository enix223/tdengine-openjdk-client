# Docker container for TDEngine client & OpenJDK

## 1. Introduction

[taos-jdbcdriver](https://docs.tdengine.com/reference/connector/java/) implement two types of connection methods:
* **Native connection**
* **REST connection**

This repo's target is to build a container for tdengine java client to run with **native connection**.

Please note: This image is base on [eclipse-temurin focal](https://hub.docker.com/_/eclipse-temurin) (Official Images for OpenJDK binaries).

## 2. Usage

Run TDengine container

```shell
docker run -it --rm -d \
    --hostname=tdengine \
    -p 6030-6041:6030-6041 \
    -p 6030-6041:6030-6041/udp \
    tdengine/tdengine:3.0.2.3
```

Run java client

```shell
docker run -it --rm -v PATH_TO_YOUR_JAR_FILE.jar:/app.jar \
    -v PATH_TO_YOUR_TAOS_CONFIG/taos.cfg:/etc/taos/taos.cfg \
    --add-host=tdengine:172.17.0.2 \
    enix223/tdengine-openjdk-client:3.0.2.3 \
    java -jar /app.jar
```

For more information, please refer to [example](./example/).

## 3. Building image

Argument:

* JDKVER - OpenJDK version, default to **17**
* TDVERSION - TDEngine version, default to **3.0.2.3**

Build command

docker pull eclipse-temurin:17.0.6_10-jdk-focal

```shell
docker build \
    --build-arg JDKVER=17.0.6_10 \
    --build-arg TDVERSION=3.0.2.5 \
    --tag enix223/tdengine-openjdk-client:17.0.6_10-3.0.2.5 \
    --tag enix223/tdengine-openjdk-client:17-3.0.2.5 \
    .
```
