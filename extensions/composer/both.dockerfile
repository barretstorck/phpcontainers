ARG COMPOSER_VERSION=latest-stable
ADD https://getcomposer.org/download/$COMPOSER_VERSION/composer.phar /bin/composer

RUN chmod 755 /bin/composer