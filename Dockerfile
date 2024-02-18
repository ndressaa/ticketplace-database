FROM postgres:15

RUN apt-get update \
      && apt-cache showpkg postgresql-$PG_MAJOR-pgaudit \
      && (apt-get install -y --no-install-recommends \
        postgresql-$PG_MAJOR-pgaudit \
        || apt-get install -y --no-install-recommends \
        postgresql-12-pgaudit) \
      && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /docker-entrypoint-initdb.d

RUN apt-get update && apt-get install -y --no-install-recommends \
  postgresql-$PG_MAJOR-pgaudit openssl

# Make ENV variables available to intermediate containers
ARG C_SSL_ON
ARG SSL_CERTS_NAME
ARG SSL_CERTS_FOLDER

RUN if [ ! -z "$C_SSL_ON" ]; then \
    # Since WORKDIR doesnt expand bash variables we need to use mkdir + cd
    mkdir -p "${SSL_CERTS_FOLDER}" && cd "${SSL_CERTS_FOLDER}" && \
    openssl req -new -text -passout pass:abcd -subj /CN=localhost -out server.req -keyout privkey.pem; \
    openssl rsa -in privkey.pem -passin pass:abcd -out "${SSL_CERTS_NAME}.key"; \
    openssl req -x509 -in server.req -text -key "${SSL_CERTS_NAME}.key" -out "${SSL_CERTS_NAME}.crt"; \
    chmod 600 "${SSL_CERTS_NAME}.key"; \
    chown postgres:root "${SSL_CERTS_NAME}.key"; \
  fi


# Copy the schema files to the initdb.d folder
COPY db-migration/*.schema.sql /docker-entrypoint-initdb.d/

# Copy the seed files to the initdb.d folder
COPY db-migration/*.seed.sql /docker-entrypoint-initdb.d/

WORKDIR /