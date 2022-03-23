FROM ryantate13/alpine:3.15
# add node user for privilege drop
RUN addgroup -g 1000 node && adduser -u 1000 -G node -D node
RUN apk add --update --no-cache nodejs
RUN mkdir /app && chown -R node:node /app
WORKDIR /app
USER node