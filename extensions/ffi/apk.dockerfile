RUN apk add --no-cache --virtual .build-deps \
        libffi-dev \
        && docker-php-ext-install ffi \
        && apk del .build-deps \
        && apk cache purge