RUN apk add --no-cache --virtual .build-deps icu-dev \
    && docker-php-ext-install intl \
    && apk del .build-deps \
    && apk cache purge