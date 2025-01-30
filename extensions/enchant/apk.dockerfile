RUN apk add --no-cache --virtual .build-deps \
        enchant2-dev \
        && docker-php-ext-install enchant \
        && apk del .build-deps \
        && apk cache purge