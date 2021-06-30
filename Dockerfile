FROM alpine:3.14

MAINTAINER Lukasz Marcin Podkalicki <lpodkalicki@gmail.com>

# Prepare directory for tools
ARG TOOLS_PATH=/tools
RUN mkdir ${TOOLS_PATH}
WORKDIR ${TOOLS_PATH}

# Install basic programs and custom glibc
ARG GLIBC_VERSION=2.33-r0
ARG GLIBC_APK_NAME=glibc-${GLIBC_VERSION}.apk 
ARG GLIBC_APK_DOWNLOAD_URL=https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/${GLIBC_APK_NAME}
RUN apk --no-cache add ca-certificates wget make cmake stlink \
	&& wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
	&& wget ${GLIBC_APK_DOWNLOAD_URL} \
	&& apk add ${GLIBC_APK_NAME} \
	&& rm ${GLIBC_APK_NAME}

# Install STM32 toolchain
# https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm/downloads
ARG TOOLCHAIN_TARBALL_URL="https://developer.arm.com/-/media/Files/downloads/gnu-rm/10-2020q4/gcc-arm-none-eabi-10-2020-q4-major-x86_64-linux.tar.bz2"
ARG TOOLCHAIN_PATH=${TOOLS_PATH}/toolchain
RUN wget ${TOOLCHAIN_TARBALL_URL} \
	&& export TOOLCHAIN_TARBALL_FILENAME=$(basename "${TOOLCHAIN_TARBALL_URL}") \
	&& tar -xvf ${TOOLCHAIN_TARBALL_FILENAME} \
	&& mv $(dirname `tar -tf ${TOOLCHAIN_TARBALL_FILENAME} | head -1`) ${TOOLCHAIN_PATH} \
	&& rm -rf ${TOOLCHAIN_PATH}/share/doc \
	&& rm ${TOOLCHAIN_TARBALL_FILENAME}

ENV PATH="${TOOLCHAIN_PATH}/bin:${PATH}"

# Change workdir
WORKDIR /build
