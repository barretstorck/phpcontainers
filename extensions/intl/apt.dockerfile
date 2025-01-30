RUN apt-get update -q \
    && apt-get install -y -q --no-install-recommends \
        libicu-dev \
    && docker-php-ext-install intl \
    && apt-get remove libicu-dev -y -q \
    && apt-get autoremove -y -q \
    && apt-get clean -q \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*