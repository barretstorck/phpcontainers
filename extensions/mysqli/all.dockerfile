# Include the PDO adapter since PDO is an extension already installed by default
RUN docker-php-ext-install mysqli pdo_mysql