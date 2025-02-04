RUN apk add --no-cache --virtual .build-deps autoconf build-base gcc \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && apk del .build-deps \
    && apk cache purge