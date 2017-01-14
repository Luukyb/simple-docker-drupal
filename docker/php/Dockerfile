FROM php:5-fpm

# Install additional tools:
RUN apt-get update -qq && apt-get install -yq \
        mysql-client \
        nano \
        vim \
        wget

# install the PHP extensions we need:
RUN apt-get update -qq && apt-get install -yq \
        libpng12-dev \
        libjpeg-dev \
        libpq-dev \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
    && docker-php-ext-install exif gd mbstring opcache pdo pdo_mysql pdo_pgsql zip

# Install Drush & Drush Registry Rebuild:
# Download latest stable release using the code below or browse to github.com/drush-ops/drush/releases.
RUN php -r "readfile('https://s3.amazonaws.com/files.drush.org/drush.phar');" > drush
# Or use our upcoming release: php -r "readfile('https://s3.amazonaws.com/files.drush.org/drush-unstable.phar');" > drush
# Make `drush` executable as a command from anywhere. Destination can be anywhere on $PATH.
RUN chmod +x drush
RUN mv drush /usr/local/bin
RUN drush dl -y --destination=/var/www/.drush registry_rebuild-7.x
RUN chown -R www-data:www-data /var/www/.drush

# Install Mailhog Sendmail support:
RUN apt-get update -qq && apt-get install -yq git golang-go \
    && mkdir -p /opt/go \
    && export GOPATH=/opt/go \
    && go get github.com/mailhog/mhsendmail

# Install Redis support:
RUN apt-get update -qq && apt-get install -yq \
        redis-tools
RUN pecl install redis-2.2.8 && docker-php-ext-enable redis

# Install & configure gosu:
# Many thanks to https://denibertovic.com/posts/handling-permissions-with-docker-volumes/
RUN apt-get update && apt-get -y --no-install-recommends install \
    ca-certificates \
    curl
RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
RUN curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture)" \
    && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture).asc" \
    && gpg --verify /usr/local/bin/gosu.asc \
    && rm /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu

# Copy PHP configs:
COPY conf.d/* /usr/local/etc/php/conf.d/
RUN chmod 644 /usr/local/etc/php/conf.d/*
RUN chgrp staff /usr/local/etc/php/conf.d/*

# Create additional Drupal file directories, and set permissions.
RUN chown www-data:www-data /var/www
RUN mkdir -p /var/www/shared/private/tmp && chown -R www-data:www-data /var/www/shared

# Set a Docker entrypoint script:
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod 755 /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

WORKDIR /var/www/html/web

CMD ["php-fpm"]
