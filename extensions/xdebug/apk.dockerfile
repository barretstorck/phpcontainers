RUN apk add --no-cache --virtual .build-deps \
        autoconf \
        build-base \
        gcc \
        linux-headers \
        && pecl install xdebug \
        && docker-php-ext-enable xdebug \
        && docker-php-source delete \
        && apk del .build-deps \
        && apk cache purge