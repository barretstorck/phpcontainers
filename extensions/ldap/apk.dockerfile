RUN apk add --no-cache --virtual .build-deps \
        openldap-dev \
        && docker-php-ext-install ldap \
        && apk del .build-deps \
        && apk cache purge