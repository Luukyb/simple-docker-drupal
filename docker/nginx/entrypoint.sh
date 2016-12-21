#!/bin/sh

# Change user:group id values for 'www-data:www-data' to match the uid:gid of
# the project docroot, unless the uid:gid are set to 0:0.
USER_ID=$(stat -c '%u' /var/www/html)
GROUP_ID=$(stat -c '%g' /var/www/html)
if [ $USER_ID != 0 ]; then
  usermod -u $USER_ID nginx
  find /var/www -user 104 -exec chown -h nginx {} \;
fi
if [ $GROUP_ID != 0 ]; then
  groupmod -g $GROUP_ID nginx
  find /var/www -group 107 -exec chgrp -h nginx {} \;
fi

if [ $1 = "nginx" ]; then
  # If first arg is `nginx`, then run as user root.
  exec "$@"
elif [ -n $1 ]; then
  # If first arg is anything else, then execute as user "nginx".
  exec /usr/local/bin/gosu nginx "$@"
else
  # If entrypoint.sh is called with no arg, execute as user root.
  exec "$@"
fi
