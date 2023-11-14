# Setup some arguments
ARG BASE_OS=ubuntu
ARG BASE_OS_VERSION=22.04
ARG BASE_IMAGE=${BASE_OS}:${BASE_OS_VERSION}

# Load base image
FROM ${BASE_IMAGE}

# Set the desired Yocto release (must be lower case)
ARG YOCTO_RELEASE=kirkstone

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
    && rm -rf /var/lib/apt/lists/* \
    && locale-gen en_US.UTF-8

# Install yocto
RUN git clone -b ${YOCTO_RELEASE} git://git.yoctoproject.org/poky.git /poky

# Update yocto/poky
WORKDIR /poky
RUN git pull origin

# Add user
RUN useradd developer -m
USER developer:developer

# Setup a work directory
VOLUME [ "/home/developer/workdir" ]
WORKDIR /home/developer/workdir

