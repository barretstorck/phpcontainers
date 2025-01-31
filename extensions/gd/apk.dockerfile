RUN apk add --no-cache --virtual .build-deps libpng-dev \
    && docker-php-ext-install gd \
    && apk del .build-deps \
    && apk cache purge