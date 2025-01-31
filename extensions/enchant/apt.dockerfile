RUN apt-get update -q \
    && apt-get install -y -q --no-install-recommends libenchant-2-dev \
    && docker-php-ext-install enchant \
    && apt-get remove libenchant-2-dev -y -q \
    && apt-get autoremove -y -q \
    && apt-get clean -q \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*