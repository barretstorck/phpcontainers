RUN apt-get update -q \
    && apt-get install -y -q --no-install-recommends libtidy-dev \
    && docker-php-ext-install tidy \
    && apt-get autoremove -y -q \
    && apt-get clean -q \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*