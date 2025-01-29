ARG COMPOSER_VERSION=latest-stable
ADD https://getcomposer.org/download/$COMPOSER_VERSION/composer.phar /bin/composer

# If we haven't already run `apt-get update` then do so.
# Then install the required apt packages for Composer.
RUN if [ -z "$(find /var/cache/apt -maxdepth 0 -mmin -60)" ]; then apt-get update -q; fi \
    && apt-get install -y -q --no-install-recommends \
        unzip \
        zip \
    && chmod 755 /bin/composer