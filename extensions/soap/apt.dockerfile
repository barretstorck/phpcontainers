RUN apt-get update -q \
    && apt-get install -y -q --no-install-recommends libxml2-dev \
    && docker-php-ext-install soap \
    && apt-get remove libxml2-dev -y -q \
    && apt-get autoremove -y -q \
    && apt-get clean -q \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*