PROJECT    := alpine
REPO       := ryantate13
IMAGE      := $(REPO)/$(PROJECT)
TAGS       := latest $(shell cat Dockerfile | grep FROM | cut -d: -f 2)
BUILD_TAGS := $(foreach TAG, $(TAGS), -t $(IMAGE):$(TAG))

docker:
	docker build --no-cache $(BUILD_TAGS) .

publish: docker
	for tag in $(TAGS); do \
		docker push $(IMAGE):$$tag; \
	done

shell: docker
	docker run -it --rm $(IMAGE) sh

.PHONY: docker publish shell
