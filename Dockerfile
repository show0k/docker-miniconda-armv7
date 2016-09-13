FROM resin/rpi-raspbian

MAINTAINER Théo Segonds <theo.segonds@inria.fr>

ENV QEMU_EXECVE 1

# Add a timestamp for the build. Also, bust the cache.
ADD http://www.timeapi.org/utc/now /opt/docker/etc/timestamp

# Modified version of qemu https://github.com/resin-io/qemu
# Highly inspired from https://github.com/resin-io-projects/armv7hf-debian-qemu
COPY qemu/resin-xbuild qemu/qemu-arm-static  /usr/bin/

RUN [ "qemu-arm-static", "/bin/sh", "-c", "ln -s resin-xbuild /usr/bin/cross-build-start; ln -s resin-xbuild /usr/bin/cross-build-end; mv /bin/sh /bin/sh.real; ln -s /bin/sh.real /bin/sh" ]

# wrap the environment with qemu allowing building on x86_64 computer
RUN [ "cross-build-start" ]

# Basic requirements
RUN apt-get update --fix-missing && apt-get install -y --no-install-recommends \
	wget curl \
	bzip2 tar unzip \
	ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 

# Compilation
RUN apt-get install -y --no-install-recommends build-essential \
	make patch cmake \
	gcc \
	g++ \
    && rm -rf /var/lib/apt/lists/*

# From https://github.com/conda-forge/docker-images/blob/master/linux-anvil/Dockerfile
# Install the latest Miniconda with Python 3 and update everything.
RUN curl -s -L http://repo.continuum.io/miniconda/Miniconda3-3.16.0-Linux-armv7l.sh > miniconda.sh && \
    openssl md5 miniconda.sh | grep a01cbe45755d576c2bb9833859cf9fd7 && \
    bash miniconda.sh -b -p /opt/conda && \
    rm miniconda.sh && \
    export PATH=/opt/conda/bin:$PATH && \
    conda config --set show_channel_urls True && \
    conda config --add channels conda-forge && \
    conda update --all --yes && \
	conda clean -tipy

ENV PATH /opt/conda/bin:$PATH

# Install Obvious-CI -> not available in linux-armV7
# RUN export PATH="/opt/conda/bin:${PATH}" && \
#    conda install --yes obvious-ci && \
#    obvci_install_conda_build_tools.py && \
#    conda clean -tipsy

# Install conda-forge git. -> not available in linux-armV7
# RUN export PATH="/opt/conda/bin:${PATH}" && \
#    conda install --yes git && \
# conda clean -tipsy

RUN [ "cross-build-end" ] 

ENTRYPOINT [ "/usr/bin/qemu-arm-static" ]
CMD [ "/bin/sh" ]

