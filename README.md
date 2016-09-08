# docker-miniconda-armv7
[![](http://dockeri.co/image/show0k/miniconda-armv7)](https://hub.docker.com/r/show0k/miniconda-armv7/)

Image used to build linux-armv7 conda package on ARM or x64 hardware.

## To run on x64 hardware:
### OSX
Docker app integrate a VM and qemu-arm-static.

```docker pull show0k/miniconda-armv7```
```docker run -it show0k/miniconda-armv7```

### GNU/Linux
You have to install qemu-arm-static :
```sudo apt-get install qemu-arm-static```

```docker pull show0k/miniconda-armv7```
```docker run -it /usr/bin/qemu-arm-static:/usr/bin/qemu-arm-static show0k/miniconda-armv7```

