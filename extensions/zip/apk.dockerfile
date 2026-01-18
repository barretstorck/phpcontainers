RUN apk add --no-cache --virtual .build-deps libzip-dev \
    && apk add --no-cache libzip \
    && docker-php-ext-install zip \
    && apk del .build-deps