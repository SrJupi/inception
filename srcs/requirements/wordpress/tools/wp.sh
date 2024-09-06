#!/bin/bash

# Function to check if WordPress is already installed
is_wp_installed() {
    echo "Here I am"
    wp core is-installed --allow-root
    return $?
}

# Function to check if the user exists
is_wp_user_created() {
    wp user get "$WP_U_NAME" --allow-root > /dev/null 2>&1
    return $?
}

# change listen port from unix socket to 9000
# sed -i '36 s@/run/php/php7.4-fpm.sock@9000@' /etc/php/7.4/fpm/pool.d/www.conf
# create a directory for php-fpm
mkdir -p /run/php

# Install WP-CLI if not already installed
if [ ! -f /usr/local/bin/wp ]; then
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
fi

# Create WordPress directories
mkdir -p /var/www/wordpress
chown -R www-data:www-data /var/www/wordpress
chmod -R 755 /var/www/wordpress
cd /var/www/wordpress

# Check if WordPress is already installed
if is_wp_installed; then
    echo "WordPress is already installed"
else
    echo "Installing WordPress"
    wp core download --allow-root
    wp core config --dbhost=mariadb:3306 --dbname="$MYSQL_DB" --dbuser="$MYSQL_USER" --dbpass="$MYSQL_PASSWORD" --allow-root
    wp core install --url="$DOMAIN_NAME" --title="$WP_TITLE" --admin_user="$WP_ADMIN_N" --admin_password="$WP_ADMIN_P" --admin_email="$WP_ADMIN_E" --allow-root
fi

# Check if the WordPress user is already created
if is_wp_user_created; then
    echo "WordPress user $WP_U_NAME already exists"
else
    echo "Creating WordPress user $WP_U_NAME"
    wp user create "$WP_U_NAME" "$WP_U_EMAIL" --user_pass="$WP_U_PASS" --role="$WP_U_ROLE" --allow-root
fi

# Start PHP-FPM
/usr/sbin/php-fpm7.4 -F
