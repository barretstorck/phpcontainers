RUN apk add --no-cache net-snmp-dev \
    && docker-php-ext-install snmp