RUN apk add --no-cache --virtual .build-deps freetds-dev \
    && docker-php-ext-install pdo_dblib \
    && apk del .build-deps \
    && apk cache purge