FROM resin/rpi-raspbian
MAINTAINER Théo Segonds <theo.segonds@inria.fr>


ENV QEMU_EXECVE 1
COPY qemu/cross-build-end qemu/cross-build-start qemu/sh-shim /usr/bin/
COPY qemu/qemu-arm-static-modified /usr/bin/qemu-arm-static

RUN [ "cross-build-start" ]
ENV LC_ALL=C.UTF-8

RUN apt-get update --fix-missing && apt-get install -y --no-install-recommends \
	wget \
	curl \
	bzip2 \
	ca-certificates \
    git \
    mercurial \
    subversion \
    && rm -rf /var/lib/apt/lists/*

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet http://repo.continuum.io/miniconda/Miniconda-latest-Linux-armv7l.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh
RUN [ "cross-build-end" ] 

ENV PATH /opt/conda/bin:$PATH

COPY qemu/qemu-arm-static-original /usr/bin/qemu-arm-static
