RUN apk add --no-cache gmp-dev \
    && docker-php-ext-install gmp