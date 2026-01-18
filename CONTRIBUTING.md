# Contributing to PHP Containers

Thank you for your interest in contributing to PHP Containers! This document outlines the standards and process for adding new extensions or improving existing ones.

## Adding a New Extension

Each extension resides in its own directory under the `extensions/` folder.

### Folder Structure
```text
extensions/
└── <extension-name>/
    ├── apt.dockerfile   # (Optional) Snippet for Debian-based images
    ├── apk.dockerfile   # (Optional) Snippet for Alpine-based images
    └── all.dockerfile   # (Optional) Shared snippet for all OS variants
```

### Snippet Standards

To keep images lightweight and efficient, please follow these guidelines:

#### 1. Debian (`apt.dockerfile`)
Always clean up the `apt` cache and remove temporary files in the same `RUN` layer.
```dockerfile
RUN apt-get update -q \
    && apt-get install -y -q --no-install-recommends <dependencies> \
    && docker-php-ext-install <extension> \
    && apt-get autoremove -y -q \
    && apt-get clean -q \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
```

#### 2. Alpine (`apk.dockerfile`)
Use virtual packages to install build-time dependencies and remove them after installation.
```dockerfile
RUN apk add --no-cache --virtual .build-deps <build-dependencies> \
    && apk add --no-cache <runtime-dependencies> \
    && docker-php-ext-install <extension> \
    && apk del .build-deps
```

#### 3. Shared Snippets (`all.dockerfile`)
Use this for instructions that are OS-agnostic, such as `docker-php-ext-install` without external dependencies.

## Testing Your Changes

Before submitting a pull request, verify that your Dockerfile generates correctly:

```shell
./bin/builddockerfile 8.4-fpm <your-extension>
```

Then, build the container and verify the extension is loaded:

```shell
make build PHP=8.4-fpm EXTENSIONS="<your-extension>"
docker run --rm php:8.4-fpm-<your-extension> php -m | grep <your-extension>
```

## Pull Request Process
1. Create a new branch for your feature or bugfix.
2. Ensure your changes follow the snippet standards.
3. Update the `README.md` table of supported extensions if you are adding a new one.
4. Submit a PR with a clear description of the changes.
