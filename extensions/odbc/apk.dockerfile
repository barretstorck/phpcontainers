RUN apk add --no-cache --virtual .build-deps unixodbc-dev \
    && apk add --no-cache unixodbc \
    && docker-php-ext-install odbc \
    && apk del .build-deps
