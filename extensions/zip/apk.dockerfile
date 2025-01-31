RUN apk add --no-cache --virtual .build-deps libzip-dev \
    && docker-php-ext-install zip \
    && apk del .build-deps \
    && apk cache purge