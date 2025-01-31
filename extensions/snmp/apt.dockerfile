RUN apt-get update -q \
    && apt-get install -y -q --no-install-recommends libsnmp-dev \
    && docker-php-ext-install snmp \
    && apt-get remove libsnmp-dev -y -q \
    && apt-get autoremove -y -q \
    && apt-get clean -q \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*