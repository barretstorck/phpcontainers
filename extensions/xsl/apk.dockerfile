RUN apk add --no-cache --virtual .build-deps libxslt-dev \
    && docker-php-ext-install xsl \
    && apk del .build-deps \
    && apk cache purge