# Miniconda armv7 crossbuild

[![Build Status](https://travis-ci.com/show0k/docker-miniconda-armv7.svg?token=q6kB4mpCcVGt4S3NTy9e&branch=master)](https://travis-ci.com/show0k/docker-miniconda-armv7)
[![CircleCI](https://circleci.com/gh/show0k/docker-miniconda-armv7.png?&style=shield)](https://circleci.com/gh/show0k/docker-miniconda-armv7)
[![](https://images.microbadger.com/badges/image/show0k/miniconda-armv7.svg)](https://hub.docker.com/r/show0k/miniconda-armv7/)

Image used to build linux-armv7 conda packages on x64 hardware. 
**It doesn't need to install qemu on the host, nor to have a kernel which support binfmt_misc.**

This image integrate a [modified version of qemu](https://github.com/resin-io/qemu). For more informations on how to mimic the kernel support of binfmt_misc, look at [this](https://resin.io/blog/building-arm-containers-on-any-x86-machine-even-dockerhub/) post or [this one](https://github.com/dockerparis/trusted-cross-build). The image is inspired by [resin/armv7hf-debian-qemu](https://github.com/resin-io-projects/armv7hf-debian-qemu).


The image provide minimal setup to build all conda recipies :
- curl & wget & ca-certificates
- git & subversion & mercurial
- conda
- conda-build

## Run it on x86_64 hardware
Every commands are started throw qemu, so you have nothing to do :

`docker run -it --rm show0k/miniconda-armv7 /bin/bash`

## Run it on ARM hardware
You have to override the entrypoint of qemu

`docker run -it --rm --entrypoint=/bin/bash show0k/miniconda-armv7`

## Continuous integration support
It works on Travis Ci and CircleCi ! Look at [.travis.yml](https://github.com/show0k/docker-miniconda-armv7/blob/master/.travis.yml) or [circle.yml](https://github.com/show0k/docker-miniconda-armv7/blob/master/circle.yml) to have basic ci examples.

## Docker build based on this image
Wrap your build steps to taint the environment with qemu allowing building on x86_64.
```docker
RUN [ "cross-build-start" ]
RUN echo do buid steps here
RUN [ "cross-build-end" ]
```
