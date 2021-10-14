PROJECT    := node
REPO       := ryantate13
IMAGE      := $(REPO)/$(PROJECT)
TAGS       := 14 lts latest
BUILD_TAGS := $(foreach TAG, $(TAGS), -t $(IMAGE):$(TAG))

define \n


endef

docker:
	docker build --no-cache $(BUILD_TAGS) .
	$(MAKE) builder

shell: docker
	docker run -it --rm $(IMAGE) sh

builder:
	docker build --no-cache -t $(IMAGE):build -f build.dockerfile .

builder/shell: builder
	docker run -it --rm $(IMAGE):build bash

publish: docker
	$(foreach tag, $(TAGS) build, docker push $(IMAGE):$(tag) $(\n))

.PHONY: docker shell builder builder/shell publish
