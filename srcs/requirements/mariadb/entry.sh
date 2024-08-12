#!/bin/bash

# Start MariaDB in the background
service mariadb start

# Wait for MariaDB to be ready
sleep 10

# Create database if not exists
mariadb -e "CREATE DATABASE IF NOT EXISTS wordpress;"

# Create user if not exists
mariadb -e "CREATE USER IF NOT EXISTS wordpressUser@'%' IDENTIFIED BY '1234';"

# Grant privileges to user
mariadb -e "GRANT ALL PRIVILEGES ON wordpress.* TO wordpressUser@'%';"

# Flush privileges to apply changes
mariadb -e "FLUSH PRIVILEGES;"

# Stop the service to run it in the foreground
service mariadb stop

# Restart mariadb with new config in the background to keep the container running
mysqld_safe --port=3306 --bind-address=0.0.0.0 --datadir='/var/lib/mysql'