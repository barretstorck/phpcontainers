RUN apt-get update -q \
    && apt-get install -y -q --no-install-recommends libbz2-dev \
    && docker-php-ext-install bz2 \
    && apt-get remove libbz2 -y -q \
    && apt-get autoremove -y -q \
    && apt-get clean -q \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*