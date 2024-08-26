#!/bin/bash

# Health check for MariaDB
mariadb -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SELECT 1;" > /dev/null 2>&1

if [ $? -neq 0 ]; then
    exit 1  # Unhealthy
fi

exit 0
