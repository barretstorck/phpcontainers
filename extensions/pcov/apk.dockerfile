RUN apk add --no-cache --virtual .build-deps autoconf build-base gcc \
    && pecl install pcov \
    && docker-php-ext-enable pcov \
    && apk del .build-deps \
    && apk cache purge