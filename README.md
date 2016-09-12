# Docker miniconda armv7
[![](http://dockeri.co/image/show0k/miniconda-armv7)](https://hub.docker.com/r/show0k/miniconda-armv7/)

Image used to build linux-armv7 conda packages on x64 or ARM hardware. It **doesn't need** to install qemu on the host, but you need to have a kernel which support binfmt_misc.

You can activate binfmt_misc on travis-ci with
```bash
echo ':arm:M::\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x28\x00:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff:/usr/bin/qemu-arm-static:' | sudo tee -a /proc/sys/fs/binfmt_misc/register
```


The image is based on resin/armv7hf-debian-qemu with a [modified version of qemu](https://github.com/resin-io/qemu) which allow building the image without binfmt_misc kernel suport (look at [this post](https://resin.io/blog/building-arm-containers-on-any-x86-machine-even-dockerhub/) for more informations).

The image include the standard qemu-arm-static in /usr/bin/.  You can run this image without modification in OSX Docker machine, in x64 Linux, and in armv7 Linux in the same way.

To test it :
`docker run -it show0k/miniconda-armv7 /bin/sh`

## Continius integration support
### Travis Ci
Travis-ci support binfmt_misc on the standard build (`sudo: required`).
An example of .travis.yml config file :
```yml
sudo: required

services:
  - docker

install: true

before_script:
  - echo ':arm:M::\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x28\x00:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff:/usr/bin/qemu-arm-static:' | sudo tee -a /proc/sys/fs/binfmt_misc/register
script:
  - docker run -it show0k/miniconda-armv7 uname -a
```
More information on docker for travis-ci [here](https://docs.travis-ci.com/user/docker/).

### CircleCi
CircleCi **does not** [support](https://discuss.circleci.com/t/add-binfmt-misc-support-for-cross-compilation/2264) binfmt_misc. I didn't manage to start arm docker image on it.
