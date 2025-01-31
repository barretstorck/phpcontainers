RUN echo 'http://dl-cdn.alpinelinux.org/alpine/v3.6/community' >> /etc/apk/repositories \
    && apk add --no-cache --virtual .build-deps tidyhtml-dev \
    && docker-php-ext-install tidy \
    && apk del .build-deps \
    && apk cache purge