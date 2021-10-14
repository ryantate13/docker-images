FROM ryantate13/node:lts
USER root

RUN wget -O /bin/wait https://github.com/ufoscout/docker-compose-wait/releases/download/2.7.3/wait \
    && chmod +x /bin/wait

RUN apk add --update --no-cache \
    g++ \
    make \
    python3 \
    py3-pip \
    vim \
    curl \
    jq \
    bash \
    zsh \
    git \
    npm \
    && npm i -g npm yarn \
    && pip3 install pip wheel
