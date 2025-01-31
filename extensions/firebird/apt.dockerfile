RUN apt-get update -q \
    && apt-get install -y -q --no-install-recommends firebird-dev \
    && docker-php-ext-install pdo_firebird \
    && apt-get remove firebird-dev -y -q \
    && apt-get autoremove -y -q \
    && apt-get clean -q \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*