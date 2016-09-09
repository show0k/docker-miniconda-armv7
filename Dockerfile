FROM resin/armv7hf-debian-qemu

MAINTAINER Théo Segonds <theo.segonds@inria.fr>

RUN [ "cross-build-start" ]
ENV LANG C.UTF-8


RUN apt-get update --fix-missing && apt-get install -y --no-install-recommends \
	wget \
	curl \
	bzip2 \
	ca-certificates \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet http://repo.continuum.io/miniconda/Miniconda-latest-Linux-armv7l.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh
RUN [ "cross-build-end" ] 

ENV PATH /opt/conda/bin:$PATH

COPY qemu-arm-static /usr/bin/qemu-arm-static
