RUN apt-get update -q \
    && apt-get install -y -q --no-install-recommends libyaml-dev \
    && pecl install yaml \
    && docker-php-ext-enable yaml \
    && apt-get remove libyaml-dev -y -q \
    && apt-get autoremove -y -q \
    && apt-get clean -q \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*