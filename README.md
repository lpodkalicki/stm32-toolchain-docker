# Overview

Lightweight docker image built on top of **alpine:3.10** with installed ARM-none-eabi toolchain and few additional tools:
* ARM-none-eabi toolchain (2020; GNU Tools for Arm Embedded Processors 9-2020-q2-update)
* stlink (v1.5)
* make (v4.2)
* cmake (v3.14)

DockerHub: https://hub.docker.com/r/lpodkalicki/stm32-toolchain

## Building image locally

```bash
git clone git@github.com:lpodkalicki/stm32-toolchain-docker.git
cd stm32-toolchain
docker build --rm -t lpodkalicki/stm32-toolchain:latest .
```

## An example of running toolchain binary

```bash
docker run --rm --privileged -v $(pwd):/build lpodkalicki/stm32-toolchain arm-none-eabi-cpp -version
```

# Installing

Bellow you can find recommended simple one-line installer that pulls the newest docker-image and installs **stm32-toolchain** script into "/usr/bin/" directory.

```bash
curl https://raw.githubusercontent.com/lpodkalicki/stm32-toolchain-docker/master/install.sh | bash -s --
```

## Getting started

1. Install toolchain using recommended simple one-line installer.
2. Use super command **stm32-toolchain** for all toolchain binaries. 
3. Execute toolchain binaries inside your working/project directory. 

## Examples

```bash
$ cd your-project/
$ stm32-toolchain arm-none-eabi-cpp --version
$ stm32-toolchain st-flash --version
$ stm32-toolchain make -version
$ stm32-toolchain cmake -version
$ stm32-toolchain cmake -Bbuild
$ stm32-toolchain make --directory build
```
