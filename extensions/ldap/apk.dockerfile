RUN apk add --no-cache --virtual .build-deps openldap-dev \
    && apk add --no-cache openldap-libs \
    && docker-php-ext-install ldap \
    && apk del .build-deps