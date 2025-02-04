RUN pecl install redis \
    && docker-php-ext-enable redis