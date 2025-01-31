RUN apt-get update -q \
    && apt-get install -y -q --no-install-recommends freetds-dev \
    && docker-php-ext-install pdo_dblib \
    && apt-get remove freetds-dev -y -q \
    && apt-get autoremove -y -q \
    && apt-get clean -q \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*