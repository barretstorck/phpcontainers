RUN apk add --no-cache --virtual .build-deps libxml2-dev \
    && apk add --no-cache libxml2 \
    && docker-php-ext-install soap \
    && apk del .build-deps