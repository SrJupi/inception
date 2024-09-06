FROM debian:bullseye

# Update and install required packages
RUN apt-get update && apt-get install -y curl php php7.4-fpm php-mysql && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy the custom PHP-FPM configuration
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# Copy the WordPress setup script
COPY ./tools/wp.sh /
COPY ./tools/health.sh /

# Change permissions to make the scripts executable
RUN chmod +x wp.sh health.sh

# Define the entrypoint command
ENTRYPOINT ["./wp.sh"]
