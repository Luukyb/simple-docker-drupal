FROM nginx

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

# Copy Nginx configs:
COPY conf.d/* /etc/nginx/conf.d/
RUN chmod 644 /etc/nginx/conf.d/*

# Create www directory, and set permissions.
RUN mkdir -p /var/www && chown nginx:nginx /var/www

# Set a Docker entrypoint script:
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod 755 /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]

WORKDIR /var/www/html/web
