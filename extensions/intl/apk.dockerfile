RUN apk add --no-cache --virtual .build-deps icu-dev \
    && apk add --no-cache icu-libs \
    && docker-php-ext-install intl \
    && apk del .build-deps
