FROM alpine:3.10

MAINTAINER Lukasz Marcin Podkalicki <lpodkalicki@gmail.com>

# Prepare directory for tools
ARG TOOLS_PATH=/tools
RUN mkdir ${TOOLS_PATH}
WORKDIR ${TOOLS_PATH}

# Install basic programs and custom glibc
RUN apk --no-cache add ca-certificates wget make cmake stlink \
	&& wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
	&& wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.32-r0/glibc-2.32-r0.apk \
	&& apk add glibc-2.32-r0.apk \
	&& rm glibc-2.32-r0.apk

# Install STM32 toolchain
ARG TOOLCHAIN_TARBALL_URL="https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2020q2/gcc-arm-none-eabi-9-2020-q2-update-x86_64-linux.tar.bz2"
ARG TOOLCHAIN_PATH=${TOOLS_PATH}/toolchain
RUN wget ${TOOLCHAIN_TARBALL_URL} \
	&& export TOOLCHAIN_TARBALL_FILENAME=$(basename "${TOOLCHAIN_TARBALL_URL}") \
	&& tar -xvf ${TOOLCHAIN_TARBALL_FILENAME} \
	&& mv `tar -tf ${TOOLCHAIN_TARBALL_FILENAME} | head -1` ${TOOLCHAIN_PATH} \
	&& rm -rf ${TOOLCHAIN_PATH}/share/doc \
	&& rm ${TOOLCHAIN_TARBALL_FILENAME}

ENV PATH="${TOOLCHAIN_PATH}/bin:${PATH}"

# Change workdir
WORKDIR /build
