DOCKER_REGISTRY_USER ?= loktionovam

SEARCH_ENGINE_UI_DOCKER_DIR ?= ./
SEARCH_ENGINE_UI_DOCKER_IMAGE_NAME ?= search_engine_ui
SEARCH_ENGINE_UI_DOCKER_IMAGE_TAG ?= $(shell ./get_dockerfile_version.sh $(SEARCH_ENGINE_UI_DOCKER_DIR)/Dockerfile)
SEARCH_ENGINE_UI_DOCKER_IMAGE ?= $(DOCKER_REGISTRY_USER)/$(SEARCH_ENGINE_UI_DOCKER_IMAGE_NAME):$(SEARCH_ENGINE_UI_DOCKER_IMAGE_TAG)

all: build push

build:
	@echo ">> building docker image $(SEARCH_ENGINE_UI_DOCKER_IMAGE)"
	@cd "$(SEARCH_ENGINE_UI_DOCKER_DIR)"; \
	echo `git show --format="%h" HEAD | head -1` > build_info.txt; \
	echo `git rev-parse --abbrev-ref HEAD` >> build_info.txt; \
	docker build -t $(SEARCH_ENGINE_UI_DOCKER_IMAGE) .

push:
	@echo ">> push $(SEARCH_ENGINE_UI_DOCKER_IMAGE) docker image to dockerhub"
	@docker push "$(SEARCH_ENGINE_UI_DOCKER_IMAGE)"

.PHONY: all build push
