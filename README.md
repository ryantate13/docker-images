# Containers

This repo houses the Dockerfiles to build all `ryantate13/*` Docker images.

## Build and publish all images

```bash
make
``` 

## Build an image locally

```bash
cd $IMG_NAME && make build
```

## Launch a shell inside image

```bash
cd $IMG_NAME && make shell
```

## Available Images

* [alpine](alpine)
* [node](node)
