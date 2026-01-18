RUN apk add --no-cache --virtual .build-deps gmp-dev \
    && apk add --no-cache gmp \
    && docker-php-ext-install gmp \
    && apk del .build-deps