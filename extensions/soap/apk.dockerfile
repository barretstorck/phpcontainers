RUN apk add --no-cache --virtual .build-deps libxml2-dev \
    && docker-php-ext-install soap \
    && apk del .build-deps \
    && apk cache purge