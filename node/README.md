# node

Docker container for NodeJS-based applications. Comes in two flavors, `ryantate13/node` for production code and `ryantate13/node:build` for dev and test, and for build steps in [multi-stage builds](https://docs.docker.com/develop/develop-images/multistage-build/). 

## `FROM node` Considered Harmful

The [default node image](https://hub.docker.com/_/node/) comes with a bunch of cruft you really don't want hanging around in your production containers due to the need to compile native modules using node-gyp. Node-gyp [depends on Python](https://github.com/nodejs/node-gyp#configuring-python-dependency), so you'll wind up with not only a full NodeJS install, but a C++ compiler, make and Python thrown in for the bargain. In a multi-stage build, you want these utilities to be available to build your bundle. In production code, it's better to compile your code once in the build step and then copy the prepared code base to the production stage. This helps in decreasing the attack surface of the final container and leads to much smaller image size overall. The production version (tagged as `latest`, `14` and `lts`) does not ship with any of these build tools including package managers npm and yarn. As a result of this, scripts such as `npm run foo` must be specified explicitly as `node ...args` to launch the production application correctly.

```console
➜  ~ docker images --filter=reference='ryantate13/node:18' --filter=reference='node:18'
REPOSITORY        TAG       IMAGE ID       CREATED          SIZE
ryantate13/node   18        c70aef3b8fd8   34 minutes ago   58.7MB
node              18        45ffe1fa9234   6 days ago       997MB
```

## Use in Multi-Stage Builds

```dockerfile
FROM ryantate13/node:build as build
COPY app /app
# npm, yarn, g++ etc. are available for build step
RUN npm install && npm run build

FROM ryantate13/node:lts
COPY --from=build /app /app
# npm start will not work here
CMD ["node", "/app"]
```

**NOTE:** `CMD` step in final layer does not call `npm start` or equivalent.


## Users

The main image has a `node` user and group (uid/gid 1000) available for running applications. This user [should be used as a matter of best practice](https://snyk.io/blog/10-docker-image-security-best-practices/) to drop privileges prior to launching your app, and is set as the default `USER` for the image. To configure steps in your final image requiring root permissions, refer to example below. 

```dockerfile
USER root
RUN apk add needed packages
USER node
CMD ["launch", "app"]
```
