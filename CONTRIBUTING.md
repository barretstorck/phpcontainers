# Contributing to PHP Containers

Thank you for your interest in contributing to PHP Containers! This document outlines the standards and process for adding new extensions or improving existing ones.

## Adding a New Extension

Each extension resides in its own directory under the `extensions/` folder.

### Folder Structure
```text
extensions/
└── <extension-name>/
    └── config   # Shell script defining dependencies and installation commands
```

### Config File Standards

The `config` file is a sourced shell script that can define the following variables:

- `APT_DEPS`: Space-separated list of Debian/Ubuntu packages (e.g., `libpng-dev`).
- `APK_DEPS`: Space-separated list of Alpine packages (e.g., `libpng-dev`).
- `PHP_EXT_INSTALL`: List of extensions to install via `docker-php-ext-install`.
- `PECL_INSTALL`: List of extensions to install via `pecl install`.
- `PHP_EXT_ENABLE`: List of extensions to enable via `docker-php-ext-enable`.
- `DOCKERFILE_CONTENTS`: Custom Dockerfile commands (e.g., `COPY`, `RUN ...`).

You can use the `IS_APK` variable to check if the target is Alpine (non-empty) or Debian (empty).

#### Example: `extensions/yaml/config`
```bash
APT_DEPS="libyaml-dev"
APK_DEPS="yaml-dev"
PECL_INSTALL="yaml"
PHP_EXT_ENABLE="yaml"
```

#### Example: `extensions/gd/config`
```bash
APT_DEPS="libpng-dev"
APK_DEPS="libpng-dev"
PHP_EXT_INSTALL="gd"
```

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
