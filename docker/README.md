## Docker Container Management Guide

This is a sub-document of the [Simple Docker Drupal Readme][].

#### Using Docker Compose in the project directory

```sh
docker-compose build  # Build or rebuild services.
docker-compose up     # Create and start containers (foreground).
docker-compose up -d  # Create and start containers (background).
docker-compose ps     # List containers.
docker-compose stop   # Stop services.
# Use with caution - this will blow away your project's database:
docker-compose down   # Remove containers, networks, images, and volumes.
```

#### Using Docker for system-wide management & cleanup

```sh
docker ps                                              # List running containers.
docker ps -a                                           # List all containers.
docker images                                          # List all images.
docker stop $(docker ps -q)                            # Stop all running containers
docker rmi $(docker images -f "dangling=true" -q)      # Delete dangling images.
docker volume rm $(docker volume ls -qf dangling=true) # Delete dangling volumes.
# Use with caution - this will blow away all local databases that are not running:
docker rm $(docker ps -q -f status=exited)             # Delete all containers that are stopped.
```

[Simple Docker Drupal Readme]: ../README.md
