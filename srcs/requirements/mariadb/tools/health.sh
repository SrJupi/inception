#!/bin/bash

LOG_FILE="/var/log/mariadb_health.log"

# Function to log with a timestamp
log_with_timestamp() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> $LOG_FILE
}

# Check if MariaDB is running by checking the process ID
if ! pgrep mysqld > /dev/null; then
    log_with_timestamp "MariaDB is not running"
    exit 1
fi

# Check if the database exists
mariadb -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "USE $MYSQL_DB;" 2>/dev/null
if [ $? -ne 0 ]; then
    log_with_timestamp "Database $MYSQL_DB does not exist"
    exit 1
fi

log_with_timestamp "MariaDB is healthy and the database exists"
exit 0
