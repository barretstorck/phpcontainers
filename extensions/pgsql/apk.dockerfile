RUN apk add --no-cache --virtual .build-deps libpq-dev \
    && apk add --no-cache libpq \
    && docker-php-ext-install pgsql pdo_pgsql \
    && apk del .build-deps
