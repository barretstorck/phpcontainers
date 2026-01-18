RUN apk add --no-cache --virtual .build-deps enchant2-dev \
    && apk add --no-cache enchant2 \
    && docker-php-ext-install enchant \
    && apk del .build-deps