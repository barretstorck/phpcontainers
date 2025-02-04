ARG NODE_VERSION=22

RUN apt-get update -q \
    && apt-get install -y -q --no-install-recommends ca-certificates curl gnupg \
    && mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_VERSION.x nodistro main" > /etc/apt/sources.list.d/nodesource.list \
    && apt-get update -q \
    && apt-get install -y -q --no-install-recommends nodejs \
    && apt-get autoremove -y -q \
    && apt-get clean -q \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*