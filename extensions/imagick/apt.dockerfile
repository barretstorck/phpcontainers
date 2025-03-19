RUN apt-get update -q \
    && apt-get install -y -q --no-install-recommends libmagickwand-dev ghostscript gsfonts unifont \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && apt-get autoremove -y -q \
    && apt-get clean -q \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*