RUN apk add --no-cache bzip2-dev \
    && docker-php-ext-install bz2