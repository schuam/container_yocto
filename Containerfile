ARG BASE_OS=ubuntu
ARG BASE_OS_VERSION=22.04
ARG BASE_IMAGE=${BASE_OS}:${BASE_OS_VERSION}

FROM ${BASE_IMAGE}


RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC \
        apt-get install -y --no-install-recommends \
            build-essential \
            chrpath \
            cpio \
            debianutils \
            diffstat \
            file \
            gawk \
            gcc \
            git \
            iputils-ping \
            libacl1 \
            libegl1-mesa \
            liblz4-tool \
            libsdl1.2-dev \
            locales \
            mesa-common-dev \
            python3 \
            python3-git \
            python3-jinja2 \
            python3-pexpect \
            python3-pip \
            python3-subunit \
            socat \
            texinfo \
            unzip \
            wget \
            xz-utils \
            zstd \
    && apt-get autoremove --purge -y \
    && rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8

