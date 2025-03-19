RUN apk add --no-cache freetds-dev \
    && docker-php-ext-install pdo_dblib