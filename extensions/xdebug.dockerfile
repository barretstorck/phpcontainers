RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

# Add a config file
# See https://xdebug.org/docs/all_settings for more documentation on what each
# config entry does.
COPY <<EOF /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
zend_extension=xdebug

[xdebug]
xdebug.mode=off
xdebug.client_host=host.docker.internal
xdebug.client_port=9003
xdebug.start_with_request=yes
EOF

# This should be overloaded to XDEBUG_MODE=develop,debug,coverage or something
# similar when testing.
ENV XDEBUG_MODE=off