RUN apk add --no-cache --virtual .build-deps bzip2-dev 
    && apk add --no-cache bzip2-libs 
    && docker-php-ext-install bz2 
    && apk del .build-deps