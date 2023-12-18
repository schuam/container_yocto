# Setup some arguments
ARG BASE_OS=ubuntu
ARG BASE_OS_VERSION=22.04
ARG BASE_IMAGE=${BASE_OS}:${BASE_OS_VERSION}

# Load base image
FROM ${BASE_IMAGE}

# Install required packages
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
            less \
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
            tmux \
            unzip \
            vim \
            wget \
            xz-utils \
            zstd \
    && apt-get autoremove --purge -y \
    && rm -rf /var/lib/apt/lists/* \
    && locale-gen en_US.UTF-8

# Add user
RUN useradd developer -m -s /bin/bash
USER developer:developer

# Setup a work directory
VOLUME [ "/home/developer/workdir" ]
WORKDIR /home/developer/workdir

