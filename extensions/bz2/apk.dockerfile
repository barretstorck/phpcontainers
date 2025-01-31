RUN apk add --no-cache --virtual .build-deps bzip2-dev \
    && docker-php-ext-install bz2 \
    && apk del .build-deps \
    && apk cache purge