# Simple Docker Drupal

A simple Docker & Drupal for development. This is all.

## Nginx + PHP 5.6

This branch is still in progress. For more stable, use the nginx branches.

What's included:

- Nginx
- PHP-FPM 5.6
- Mariadb

Check the other branches of this repo for some more options.

### Official containers only

All of this is based on officials containers, so you won't download any
specific containers to use this project.

### Get started

All your Drupal files should be placed into the folder "web".

```sh
mkdir web
```

Add the project domain to your local Hosts file, and point it to `127.0.100.100`.

* Paste the following into `/etc/hosts` (`c:\Windows\System32\drivers\etc\hosts` for Windows users):

```
127.0.100.100  drupal7.dev db.drupal7.dev
```

* Mac OSX users: Run the following to attach an unused IP to the lo0 interface.

```sh
sudo ifconfig lo0 alias 127.0.100.100/24
```

Run docker compose.

```sh
docker-compose up -d
```

Import your database or install your site.

```sh
docker-compose run --rm php ./../vendor/bin/drush site-install
```

### Database credentials
This is for development !!

- User: drupal
- Password: drupal
- Database: drupal
- Host: db.drupal.dev
- Port: 3306

### Links to local development environment & tools

- [Drupal Site](http://drupal.dev)
- [phpMyAdmin](http://drupal.dev:8080)
- [MailHog](http://drupal.dev:8025)

### Other useful shell commands

#### Opening a Bash terminal into the 'php' Docker container

```sh
docker-compose run --rm php bash
```

- Windows users: This is unavailable, for now. Docker Compose for Windows
  currently does not support
  [interactive mode](https://github.com/docker/compose/issues/3194).

#### Using Docker Compose in the project directory

```sh
docker-compose build  #Build or rebuild services.
docker-compose up     #Create and start containers (foreground).
docker-compose up -d  #Create and start containers (background).
docker-compose ps     #List containers.
docker-compose stop   #Stop services.
docker-compose down   #Remove containers, networks, images, and volumes.
```

#### Using Docker for system-wide management & cleanup

```sh
docker ps                         #List running containers.
docker ps -a                      #List all containers.
docker stop $(docker ps -q)       #Stop all running containers
docker rm $(docker ps -a -q)      #Delete all containers. Use with caution!
docker rmi -f $(docker images -q) #Delete all images.
```
