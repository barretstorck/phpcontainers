RUN apk add --no-cache libzip-dev \
    && docker-php-ext-install zip