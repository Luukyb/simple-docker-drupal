#!/bin/bash

# Change user:group id values for 'www-data:www-data' to '1000:1000':
usermod -u $(stat -c '%u' /var/www/html) www-data
groupmod -g $(stat -c '%u' /var/www/html) www-data
find /var/www -group 33 -exec chgrp -h www-data {} \;

# If entrypoint.sh is called without arguments, then execute php-fpm service:
if [ -n "$1" ]; then
  exec /usr/local/bin/gosu www-data "$@"
else
  exec php-fpm
fi
