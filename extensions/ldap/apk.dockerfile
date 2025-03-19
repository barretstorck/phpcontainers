RUN apk add --no-cache openldap-dev \
    && docker-php-ext-install ldap