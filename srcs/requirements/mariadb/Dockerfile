# mariadb/Dockerfile
FROM debian:bullseye

# Install necessary packages
RUN apt-get update && \
    apt-get install -y mariadb-server && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# copy files from host to container
COPY ./entry.sh /usr/local/bin/entry.sh
COPY ./health.sh /usr/local/bin/health.sh

# Give execution permissions to the script
RUN chmod +x /usr/local/bin/entry.sh /usr/local/bin/health.sh

ENTRYPOINT ["/usr/local/bin/entry.sh"]