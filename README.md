# Docker container for TDEngine client & OpenJDK

## 1. Introduction

[taos-jdbcdriver](https://docs.tdengine.com/reference/connector/java/) implement two types of connection methods:
* **Native connection**
* **REST connection**

This repo's target is to build a container for tdengine java client to run with **native connection**.

Please note: This image is base on [eclipse-temurin](https://hub.docker.com/_/eclipse-temurin) image (Official Images for OpenJDK binaries).

## 2. Usage

Run TDengine container

```shell
docker run -it --rm -d \
    --name tdengine-openjdk-demo \
    --hostname=tdengine \
    -p 6030-6041:6030-6041 \
    -p 6030-6041:6030-6041/udp \
    tdengine/tdengine:3.0.2.5
```

Run java client

```shell
docker run -it --rm \
    -v YOUR_PATH_TO_JAVA_CLIENT/client.jar:/app.jar \
    -v YOUR_PATH_TO_TAOS_CONFIG/taos.cfg:/etc/taos/taos.cfg \
    --add-host=tdengine:TDENGINE_DB_DOCKER_IP_ADDRESS \
    enix223/tdengine-openjdk-client:17-3.0.2.5 \
    java -jar /app.jar
```

For more information, please refer to [example](./example/).

## 3. Building image

Argument:

* JDKVER - OpenJDK image tag, default to **17.0.6_10**
* TDVERSION - TDEngine version, default to **3.0.2.3**


### 3.1 Build focal image

docker pull eclipse-temurin:17.0.6_10-jdk-focal

```shell
docker build \
    -f Dockerfile_focal \
    --build-arg JDKVER=17.0.6_10 \
    --build-arg TDVERSION=3.0.2.5 \
    --tag enix223/tdengine-openjdk-client:17.0.6_10-jdk-focal-3.0.2.5 \
    --tag enix223/tdengine-openjdk-client:17-jdk-focal-3.0.2.5 \
    .
```

### 3.2 Build alpine image

docker pull eclipse-temurin:17.0.6_10-jdk-alpine

```shell
docker build \
    -f Dockerfile_alpine \
    --build-arg JDKVER=17.0.6_10 \
    --build-arg TDVERSION=3.0.2.5 \
    --tag enix223/tdengine-openjdk-client:17.0.6_10-jdk-alpine-3.0.2.5 \
    --tag enix223/tdengine-openjdk-client:17-jdk-alpine-3.0.2.5 \
    .
```
