RUN apt-get update -q \
    && apt-get install -y -q --no-install-recommends libgmp-dev \
    && docker-php-ext-install gmp \
    && apt-get remove libgmp-dev -y -q \
    && apt-get autoremove -y -q \
    && apt-get clean -q \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*