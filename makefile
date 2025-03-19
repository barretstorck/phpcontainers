MKFILE_DIR = $(shell echo $(dir $(abspath $(firstword $(MAKEFILE_LIST)))) | sed -e 's,/$$,,')

PHP=8.4-cli
EXTENSIONS=
NAME=php
TAG = $(shell echo ${PHP}-$$(echo ${EXTENSIONS} | tr '[:upper:]' '[:lower:]' | xargs -n1 | sort | xargs | tr ' ' '-') | cut -c -128 | sed 's/-$$//')

.PHONY: *

# Build the Docker containers.
build:
	$(MKFILE_DIR)/bin/builddockerfile ${PHP} ${EXTENSIONS} | docker build \
		--build-arg='PHP_TAG=${PHP}' \
		--tag ${NAME}:${TAG} \
		--file - \
		$(MKFILE_DIR)

build-no-cache:
	$(MKFILE_DIR)/bin/builddockerfile ${PHP} ${EXTENSIONS} | docker build \
		--build-arg='PHP_TAG=${PHP}' \
		--no-cache \
		--tag ${NAME}:${TAG} \
		--file - \
		$(MKFILE_DIR)

clean:
	docker image rm ${NAME}:${TAG} >/dev/null 2>&1 || true

dockerfile:
	$(MKFILE_DIR)/bin/builddockerfile ${PHP} ${EXTENSIONS}
