# PHP Containers
This repository provides scripts made to streamline the process of building
[PHP Docker containers](https://hub.docker.com/_/php) with various extensions.
Once built, these containers serve as an ideal 
This empowers developers to create lightweight, efficient, and reproducible PHP
containers with any combination of the supported extensions listed
[below](#supported-extensions).

# Supported Extensions
| Extension | Debian | Alpine | Comment |
|---|:-:|:-:|---|
| [bcmath](https://www.php.net/manual/en/book.bc.php) | ☑ | ☑ |  |
| [bz2](https://www.php.net/manual/en/book.bzip2.php) | ☑ | ☑ |  |
| [calendar](https://www.php.net/manual/en/book.calendar.php) | ☑ | ☑ |  |
| [composer](https://getcomposer.org/download/) | ☑ | ☑ | Adds Composer binary |
| [dba](https://www.php.net/manual/en/book.dba.php) | ☑ | ☑ |  |
| [dblib](https://www.php.net/manual/en/ref.pdo-dblib.connection.php) | ☑ | ☑ |  |
| dl_test | ☑ | ☑ |  |
| [enchant](https://www.php.net/manual/en/book.enchant.php) | ☑ | ☑ |  |
| [exif](https://www.php.net/manual/en/book.exif.php) | ☑ | ☑ |  |
| [ffi](https://www.php.net/manual/en/book.ffi.php) | ☑ | ☑ |  |
| [ftp](https://www.php.net/manual/en/book.ftp.php) | ☑ | ☑ |  |
| [gd](https://www.php.net/manual/en/book.image.php) | ☑ | ☑ |  |
| [gettext](https://www.php.net/manual/en/book.gettext.php) | ☑ | ☑ |  |
| [gmp](https://www.php.net/manual/en/book.gmp.php) | ☑ | ☑ |  |
| [imagick](https://www.php.net/manual/en/book.imagick.php) | ☑ | ☐ |  |
| [intl](https://www.php.net/manual/en/book.intl.php) | ☑ | ☑ |  |
| [ldap](https://www.php.net/manual/en/book.ldap.php) | ☑ | ☑ |  |
| [mysqli](https://www.php.net/manual/en/book.mysqli.php) | ☑ | ☑ | Includes pdo_mysql |
| [nodejs](https://nodejs.org/en/learn/getting-started/introduction-to-nodejs) | ☑ | ☑ | Adds NodeJS |
| [odbc](https://www.php.net/manual/en/book.uodbc.php) | ☑ | ☑ | Includes pdo_odbc |
| [opcache](https://www.php.net/manual/en/book.opcache.php) | ☑ | ☑ |  |
| [pcntl](https://www.php.net/manual/en/book.pcntl.php) | ☑ | ☑ |  |
| [pcov](https://github.com/krakjoe/pcov) | ☑ | ☑ |  |
| [pdo_dblib](https://www.php.net/manual/en/ref.pdo-dblib.connection.php) | ☑ | ☑ | Bundled in "dblib" |
| [pdo_firebird](https://www.php.net/manual/en/ref.pdo-firebird.php) | ☑ | ☐ |  |
| [pdo_mysql](https://www.php.net/manual/en/ref.pdo-mysql.php) | ☑ | ☑ | Bundled in "mysqli" |
| [pdo_odbc](https://www.php.net/manual/en/ref.pdo-odbc.php) | ☑ | ☑ | Bundled in "odbc" |
| [pdo_pgsql](https://www.php.net/manual/en/ref.pdo-pgsql.php) | ☑ | ☑ | Bundled in "pgsql" |
| [pgsql](https://www.php.net/manual/en/book.pgsql.php) | ☑ | ☑ | Includes pdo_pgsql |
| [shmop](https://www.php.net/manual/en/book.shmop.php) | ☑ | ☑ |  |
| [snmp](https://www.php.net/manual/en/book.snmp.php) | ☑ | ☑ |  |
| [soap](https://www.php.net/manual/en/book.soap.php) | ☑ | ☑ |  |
| [sockets](https://www.php.net/manual/en/book.sockets.php) | ☑ | ☑ |  |
| [sysvmsg](https://www.php.net/manual/en/book.sem.php) | ☑ | ☑ |  |
| [sysvsem](https://www.php.net/manual/en/book.sem.php) | ☑ | ☑ |  |
| [sysvshm](https://www.php.net/manual/en/book.sem.php) | ☑ | ☑ |  |
| [tidy](https://www.php.net/manual/en/book.tidy.php) | ☑ | ☑ |  |
| [xdebug](https://xdebug.org) | ☑ | ☑ |  |
| [xsl](https://www.php.net/manual/en/book.xsl.php) | ☑ | ☑ |  |
| [yaml](https://www.php.net/manual/en/book.yaml.php) | ☑ | ☑ |  |
| [zip](https://www.php.net/manual/en/book.zip.php) | ☑ | ☑ |  |

# Example
### A lightweight PHP development environment
```shell
# Build a PHP 8.4 cli alpine container with the composer and xdebug extensions
make build PHP=8.4-cli-alpine EXTENSIONS="composer xdebug"

# Run the `composer -v` command on the newly made container
docker run -it --rm php:8.4-cli-alpine-composer-xdebug composer -V
Composer version 2.8.5 2025-01-21 15:23:40
PHP version 8.4.3 (/usr/local/bin/php)
Run the "diagnose" command to get more detailed diagnostics output.
```

# How it works
Each extension is defined within its own directory, with one or more dockerfiles
included. The `bin/builddockerfile` script accepts the tag name of the PHP
Docker container to use as a base, and a list of extensions to include. From
that the script fetches the appropriate dockerfile snippets from each
extension's directory, and compiles a new dockerfile that the final image will
be made from.

To preview the dockerfile, you can run `./bin/builddockerfile <php base tag name> <list of extensions>`.
For example:
```shell
./bin/builddockerfile 8.4-fpm bcmath bz2 yaml zip
```
will output:
```dockerfile
FROM php:8.4-fpm

# Setup bcmath
RUN docker-php-ext-install bcmath

# Setup bz2
RUN apt-get update -q \
    && apt-get install -y -q --no-install-recommends libbz2-dev \
    && docker-php-ext-install bz2 \
    && apt-get remove libbz2 -y -q \
    && apt-get autoremove -y -q \
    && apt-get clean -q \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Setup yaml
RUN apt-get update -q \
    && apt-get install -y -q --no-install-recommends libyaml-dev \
    && pecl install yaml \
    && docker-php-ext-enable yaml \
    && apt-get remove libyaml-dev -y -q \
    && apt-get autoremove -y -q \
    && apt-get clean -q \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Setup zip
RUN apt-get update -q \
    && apt-get install -y -q --no-install-recommends libzip-dev \
    && docker-php-ext-install zip \
    && apt-get remove libzip-dev -y -q \
    && apt-get autoremove -y -q \
    && apt-get clean -q \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
```