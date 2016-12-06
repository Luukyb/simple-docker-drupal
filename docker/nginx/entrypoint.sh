#!/bin/bash

# Change user:group id values for 'nginx:nginx' to '1000:1000':
usermod -u $(stat -c '%u' /var/www/html) nginx
groupmod -g $(stat -c '%u' /var/www/html) nginx
find /var/www -user 104 -exec chown -h nginx {} \;
find /var/www -group 107 -exec chgrp -h nginx {} \;

# If entrypoint.sh is called without arguments, then execute php-fpm service:
if [ -n "$1" ]; then
  exec /usr/local/bin/gosu nginx "$@"
else
  nginx -g "daemon off;"
fi
