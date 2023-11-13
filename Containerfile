ARG BASE_OS=ubuntu
ARG BASE_OS_VERSION=22.04
ARG BASE_IMAGE=${BASE_OS}:${BASE_OS_VERSION}

FROM ${BASE_IMAGE}


RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        gawk \
        wget \
        git \
        diffstat \
        unzip \
        texinfo \
        gcc \
        build-essential \
        chrpath \
        socat \
        cpio \
        python3 \
        python3-pip \
        python3-pexpect \
        xz-utils \
        debianutils \
        iputils-ping \
        python3-git \
        python3-jinja2 \
        libegl1-mesa \
        libsdl1.2-dev \
        python3-subunit \
        mesa-common-dev \
        zstd \
        liblz4-tool \
        file \
        locales \
        libacl1 \
    && apt-get autoremove --purge -y \
    && rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8

