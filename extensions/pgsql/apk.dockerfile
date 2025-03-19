RUN apk add --no-cache libpq-dev \
    && docker-php-ext-install pgsql pdo_pgsql