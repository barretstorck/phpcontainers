RUN pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && docker-php-source delete