RUN apk add --no-cache --virtual .build-deps autoconf build-base gcc\
    apk add --no-cache yaml-dev \
    && pecl install yaml \
    && docker-php-ext-enable yaml \
    && apk del .build-deps \
    && apk cache purge