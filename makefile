MKFILE_DIR = $(shell echo $(dir $(abspath $(firstword $(MAKEFILE_LIST)))) | sed -e 's,/$$,,')

PHP=8.4-cli
EXTENSIONS=
NAME=php
REGISTRY=ghcr.io/barretstorck
TAG = $(shell echo ${PHP}-$$(echo ${EXTENSIONS} | tr '[:upper:]' '[:lower:]' | xargs -n1 | sort | xargs | tr ' ' '-') | cut -c -128 | sed 's/-$$//')

.PHONY: *

# Build the Docker containers.
build:
	$(MKFILE_DIR)/bin/builddockerfile ${EXTENSIONS} | docker build \
		--build-arg='PHP_TAG=${PHP}' \
		--tag ${REGISTRY}/${NAME}:${TAG} \
		--file - \
		$(MKFILE_DIR)

build-no-cache:
	$(MKFILE_DIR)/bin/builddockerfile ${EXTENSIONS} | docker build \
		--build-arg='PHP_TAG=${PHP}' \
		--no-cache \
		--tag ${REGISTRY}/${NAME}:${TAG} \
		--file - \
		$(MKFILE_DIR)

clean:
	docker image rm ${REGISTRY}/${NAME}:${TAG} >/dev/null 2>&1 || true
