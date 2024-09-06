#!/bin/bash

# Check if PHP-FPM is running
if pgrep php-fpm > /dev/null; then
    echo "PHP-FPM is running"
    exit 0
else
    echo "PHP-FPM is not running"
    exit 1
fi

