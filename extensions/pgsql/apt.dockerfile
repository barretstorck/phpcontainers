RUN apt-get update -q \
    && apt-get install -y -q --no-install-recommends libpq-dev \
    && docker-php-ext-install pgsql pdo_pgsql \
    && apt-get autoremove -y -q \
    && apt-get clean -q \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*