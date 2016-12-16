# Simple Docker Drupal

A simple Docker & Drupal for development. This is all.

### Apache + PHP 5.6

This branch is still on progress. For more stable, use the nginx branches.

What's included:

  - PHP 5.6 (based on apache)
  - Mariadb

Check the other branches of this repo for some more options.

### Official containers only
All of this is based on officials containers, so you won't download any
specific containers to use this project.

### Get started
All your Drupal files should be placed into the folder "web".

Run docker compose.
```sh
$ docker-compose up -d
```

Go into docker container.
```sh
$ docker-compose exec php /bin/bash
```

Build local.
Download db to project root production-db.sql.
```sh
cd /var/www/web
$ ../scripts/drupal-update.sh
```

### Database credentials
This is for development !!

* User: drupal
* Password: drupal
* Database: drupal
