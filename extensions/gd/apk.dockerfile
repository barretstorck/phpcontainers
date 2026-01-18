RUN apk add --no-cache --virtual .build-deps libpng-dev \
    && apk add --no-cache libpng \
    && docker-php-ext-install gd \
    && apk del .build-deps