RUN apk add --no-cache --virtual .build-deps libpq-dev \
    && docker-php-ext-install pgsql pdo_pgsql \
    && apk del .build-deps \
    && apk cache purge