RUN apk add --no-cache --virtual .build-deps unixodbc-dev \
    && docker-php-source extract \
    && echo 'AC_DEFUN([PHP_ALWAYS_SHARED],[])dnl' > temp.m4 \
    && cat /usr/src/php/ext/odbc/config.m4 >> temp.m4 \
    && mv temp.m4 /usr/src/php/ext/odbc/config.m4 \
    && docker-php-ext-configure odbc --with-unixODBC=shared,/usr \
    && docker-php-ext-configure pdo_odbc --with-pdo-odbc=unixODBC,/usr \
    && docker-php-ext-install odbc pdo_odbc \
    && docker-php-source delete \
    && apk del .build-deps \
    && apk cache purge
