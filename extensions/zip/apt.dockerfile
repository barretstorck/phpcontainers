RUN apt-get update -q \
    && apt-get install -y -q --no-install-recommends libzip-dev \
    && docker-php-ext-install zip \
    && apt-get remove libzip-dev -y -q \
    && apt-get autoremove -y -q \
    && apt-get clean -q \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*