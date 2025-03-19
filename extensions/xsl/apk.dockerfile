RUN apk add --no-cache libxslt-dev \
    && docker-php-ext-install xsl