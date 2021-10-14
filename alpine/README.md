# alpine

Base [alpine](https://alpinelinux.org/) image for further customization. Latest tag is currently based on upstream [alpine 3.14](https://hub.docker.com/_/alpine) with the addition of the [tini init system](https://github.com/krallin/tini) as well as ca-certificates for managing trust relationships with HTTPS-secured APIs. 

```Dockerfile
FROM alpine:3.14
RUN apk add tini ca-certificates
ENTRYPOINT ["tini", "--"]
```

Tini is the default entrypoint for containers based off of this image. When building from ```ryantate13/alpine``` this can be overriden by providing a new value for ```ENTRYPOINT``` but typically node/go/python etc. apps [should not be run as PID 1](https://hynek.me/articles/docker-signals/) without ensuring proper signal handling in your application code. To utilize the default behavior just set ```CMD``` in your Dockerfile to run your application. Tini will take over as PID 1 and exit your app cleanly with proper ```SIG(TERM|KILL|QUIT)``` signals so that individual containerized processes don't have to have handlers in place for these common use cases.

## Launch application using tini

```Dockerfile
FROM ryantate13/alpine
RUN ...
CMD ["my", "app"]
```

## Custom entrypoint

```Dockerfile
FROM ryantate13/alpine
RUN ...
ENTRYPOINT ["my", "entrypoint"]
```
