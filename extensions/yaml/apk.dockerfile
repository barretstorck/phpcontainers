RUN apk add --no-cache --virtual .build-deps autoconf build-base gcc yaml-dev \
    && pecl install yaml \
    && docker-php-ext-enable yaml \
    && apk del .build-deps \
    && apk cache purge