FROM resin/rpi-raspbian

MAINTAINER Théo Segonds <theo.segonds@inria.fr>

ENV QEMU_EXECVE 1

# Modified version of qemu https://github.com/resin-io/qemu
# Highly inspired from https://github.com/resin-io-projects/armv7hf-debian-qemu
COPY qemu/resin-xbuild qemu/qemu-arm-static  /usr/bin/

RUN [ "qemu-arm-static", "/bin/sh", "-c", "ln -s resin-xbuild /usr/bin/cross-build-start; ln -s resin-xbuild /usr/bin/cross-build-end ; ln /bin/sh /bin/sh.real" ]

# wrap the environment with qemu allowing building on x86_64
RUN [ "cross-build-start" ]

RUN apt-get update --fix-missing && apt-get install -y --no-install-recommends \
	wget curl \
	bzip2 \
	ca-certificates \
    git mercurial subversion \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    && rm -rf /var/lib/apt/lists/*

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet http://repo.continuum.io/miniconda/Miniconda-latest-Linux-armv7l.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh
RUN [ "cross-build-end" ] 


ENTRYPOINT [ "/usr/bin/qemu-arm-static" ]
ENV PATH /opt/conda/bin:$PATH

CMD [ "/bin/bash" ]