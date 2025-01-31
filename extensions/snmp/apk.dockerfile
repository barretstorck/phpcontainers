RUN apk add --no-cache --virtual .build-deps net-snmp-dev \
    && docker-php-ext-install snmp \
    && apk del .build-deps \
    && apk cache purge