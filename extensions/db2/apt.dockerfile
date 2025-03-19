ADD https://github.com/ibmdb/db2drivers/raw/refs/heads/main/clidriver/linuxx64_odbc_cli.tar.gz /driver.tar.gz

RUN tar -xzvf /driver.tar.gz -C / \
    && pecl bundle --destination=/ ibm_db2 \
    && pecl bundle --destination=/ pdo_ibm \
    && docker-php-ext-configure /ibm_db2 --with-IBM_DB2=/clidriver \
    && docker-php-ext-configure /PDO_IBM --with-pdo-ibm=/clidriver \
    && docker-php-ext-install /ibm_db2 \
    && docker-php-ext-install /PDO_IBM \
    && rm -rf /ibm_db2 /PDO_IBM /tmp/* /var/tmp/*