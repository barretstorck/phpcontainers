RUN apk add --no-cache icu-dev \
    && docker-php-ext-install intl