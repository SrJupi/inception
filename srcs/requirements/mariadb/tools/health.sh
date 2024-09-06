#!/bin/bash

LOG_FILE="/var/log/mariadb_health.log"

# Check if MariaDB is running
if ! pgrep mariadb > /dev/null; then
    echo "MariaDB is not running" >> $LOG_FILE
    exit 1
fi

# Check if the database exists
mariadb -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "USE $MYSQL_DB;" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "Database $MYSQL_DB does not exist" >> $LOG_FILE
    exit 1
fi

# Check if the user exists
USER_EXISTS=$(mariadb -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SELECT EXISTS(SELECT 1 FROM mysql.user WHERE user = '$MYSQL_USER');" | tail -n 1)
if [ "$USER_EXISTS" -eq 0 ]; then
    echo "User $MYSQL_USER does not exist" >> $LOG_FILE
    exit 1
fi

echo "MariaDB is healthy and the database and user exist" >> $LOG_FILE
exit 0
