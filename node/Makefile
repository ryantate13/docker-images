PROJECT    := node
REPO       := ryantate13
IMAGE      := $(REPO)/$(PROJECT)
TAGS       := 18 lts latest
BUILD_TAGS := $(foreach TAG, $(TAGS), -t $(IMAGE):$(TAG))
DOCKER_BUILD := docker build --no-cache

define \n


endef

docker:
	$(DOCKER_BUILD) $(BUILD_TAGS) .
	$(MAKE) builder dev

shell: docker
	docker run -it --rm $(IMAGE) sh

builder:
	$(DOCKER_BUILD) -t $(IMAGE):build -f build.dockerfile .

builder/shell:
	docker run -it --rm $(IMAGE):build zsh

dev: builder
	$(DOCKER_BUILD) -t $(IMAGE):dev -f dev.dockerfile .

dev/shell:
	docker run -it --rm $(IMAGE):dev zsh

publish: docker
	$(foreach tag, $(TAGS) build dev, docker push $(IMAGE):$(tag) $(\n))

.PHONY: docker shell builder builder/shell dev dev/shell publish
