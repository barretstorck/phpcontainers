RUN apk add --no-cache --virtual .build-deps net-snmp-dev \
    && apk add --no-cache net-snmp-libs \
    && docker-php-ext-install snmp \
    && apk del .build-deps