RUN apk add --no-cache libffi-dev \
    && docker-php-ext-install ffi