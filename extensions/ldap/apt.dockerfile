RUN apt-get update -q \
    && apt-get install -y -q --no-install-recommends libldap-dev \
    && docker-php-ext-install ldap \
    && apt-get remove libldap-dev -y -q \
    && apt-get autoremove -y -q \
    && apt-get clean -q \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*