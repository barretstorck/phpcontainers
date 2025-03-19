RUN echo 'http://dl-cdn.alpinelinux.org/alpine/v3.6/community' >> /etc/apk/repositories \
    && apk add --no-cache tidyhtml-dev \
    && docker-php-ext-install tidy