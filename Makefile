define \n


endef

define do_all
	$(foreach d, $(shell find . -type f -name Dockerfile | xargs -n 1 dirname | sort), cd $(d) && $(1)$(\n))
endef

all: publish

docker publish:
	$(call do_all, $(MAKE) $@)

docker/login:
	$(foreach env, DOCKER_USER DOCKER_PASSWORD, \
		$(if $(value $(env)),,$(error required variable $(env) is undefined)))
	@echo $(DOCKER_PASSWORD) | \
		docker login --username $(DOCKER_USER) --password-stdin

.PHONY: all docker publish docker/login