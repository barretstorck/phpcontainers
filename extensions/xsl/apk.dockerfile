RUN apk add --no-cache --virtual .build-deps libxslt-dev \
    && apk add --no-cache libxslt \
    && docker-php-ext-install xsl \
    && apk del .build-deps