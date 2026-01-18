RUN echo 'http://dl-cdn.alpinelinux.org/alpine/v3.6/community' >> /etc/apk/repositories \
    && apk add --no-cache --virtual .build-deps tidyhtml-dev \
    && apk add --no-cache tidyhtml-libs \
    && docker-php-ext-install tidy \
    && apk del .build-deps