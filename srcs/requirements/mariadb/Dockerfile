# mariadb/Dockerfile
FROM debian:bullseye

# Install necessary packages
RUN apt-get update && \
    apt-get install -y mariadb-server && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# copy file from host to container
COPY ./entry.sh usr/local/bin/entry.sh

# Give execution permissions to the script
RUN chmod +x /usr/local/bin/entry.sh

# Expose the necessary port
EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/entry.sh"]