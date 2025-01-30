RUN apk add --no-cache --virtual .build-deps \
        gmp-dev \
        && docker-php-ext-install gmp \
        && apk del .build-deps \
        && apk cache purge