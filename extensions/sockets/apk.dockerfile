RUN apk add --no-cache --virtual .build-deps linux-headers \
    && docker-php-ext-install sockets \
    && apk del .build-deps \
    && apk cache purge