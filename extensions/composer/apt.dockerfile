RUN apt-get update -q \
    && apt-get install -y -q --no-install-recommends unzip zip \
    && apt-get autoremove -y -q \
    && apt-get clean -q \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*