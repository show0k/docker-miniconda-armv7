# docker-miniconda-armv7
[![](http://dockeri.co/image/show0k/miniconda-armv7)](https://hub.docker.com/r/show0k/miniconda-armv7/)

Image used to build linux-armv7 conda packages on x64 or ARM hardware. It **doesn't need** to install qemu on the host (see below for more informations). 

The image is based on resin/armv7hf-debian-qemu with a [modified version of qemu](https://github.com/resin-io/qemu) which allow building the image without binfmt_misc kernel suport (look at [this post](https://resin.io/blog/building-arm-containers-on-any-x86-machine-even-dockerhub/) for more informations).


The image include the standard qemu-arm-static in /usr/bin/.  You can run this image without modification in OSX Docker machine, in x64 Linux, and in armv7 Linux in the same way.

To test it :
`docker run -it show0k/miniconda-armv7 /bin/sh`