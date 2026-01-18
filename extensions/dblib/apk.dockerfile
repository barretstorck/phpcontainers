RUN apk add --no-cache --virtual .build-deps freetds-dev \
    && apk add --no-cache freetds \
    && docker-php-ext-install dblib \
    && apk del .build-deps
