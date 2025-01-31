RUN apt-get update -q \
    && apt-get install -y -q --no-install-recommends libffi-dev \
    && docker-php-ext-install ffi \
    && apt-get remove libffi-dev -y -q \
    && apt-get autoremove -y -q \
    && apt-get clean -q \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*