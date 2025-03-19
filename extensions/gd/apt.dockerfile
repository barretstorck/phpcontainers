RUN apt-get update -q \
    && apt-get install -y -q --no-install-recommends libpng-dev \
    && docker-php-ext-install gd \
    && apt-get autoremove -y -q \
    && apt-get clean -q \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*