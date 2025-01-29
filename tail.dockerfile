# Clean up apt
RUN apt-get autoremove -y -q \
    && apt-get clean -q \
    && docker-php-source delete \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*