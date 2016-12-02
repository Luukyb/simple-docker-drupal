#!/bin/bash

# Change user:group id values for 'www-data:www-data' to '1000:1000'
usermod -u $(stat -c '%u' /var/www/html/web) www-data
groupmod -g $(stat -c '%u' /var/www/html/web) www-data

chown www-data:www-data /var/www

if [ -n "$1" ]; then
  echo -e "Running $@ ..."
  exec /usr/local/bin/gosu www-data "$@"
else
  exec /usr/sbin/nginx
fi
