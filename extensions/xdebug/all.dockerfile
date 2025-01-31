# Add config file
COPY extensions/xdebug/xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# This should be overloaded to XDEBUG_MODE=develop,debug,coverage or something
# similar when testing.
ENV XDEBUG_MODE=off