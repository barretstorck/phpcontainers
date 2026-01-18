RUN apk add --no-cache --virtual .build-deps libffi-dev \
    && apk add --no-cache libffi \
    && docker-php-ext-install ffi \
    && apk del .build-deps
