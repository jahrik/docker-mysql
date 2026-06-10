# MySQL (MariaDB)

[![Build](https://github.com/jahrik/docker-mysql/actions/workflows/build.yml/badge.svg)](https://github.com/jahrik/docker-mysql/actions/workflows/build.yml)

Thin multi-arch (amd64/arm64) wrapper around the official [mariadb](https://hub.docker.com/_/mariadb) LTS image, published as `jahrik/mysql` for homelab Docker Swarm deployments.

```bash
docker pull jahrik/mysql
```

## Build

```bash
make build
```

The MariaDB version is pinned in the Dockerfile `FROM` line (currently 11.8 LTS) — bump it there to upgrade. The official image is multi-arch, so no per-architecture build args are needed.

## Run

```bash
docker run -d -p 3306:3306 \
  -e MARIADB_ROOT_PASSWORD=secret \
  -e MARIADB_DATABASE=mydb \
  -e MARIADB_USER=me \
  -e MARIADB_PASSWORD=secret \
  -v mysql-data:/var/lib/mysql \
  jahrik/mysql
```

All [official mariadb environment variables](https://hub.docker.com/_/mariadb) work (the legacy `MYSQL_*` names are also accepted).

## Deploy to Docker Swarm

`docker-compose.yml` deploys a replicated service on the external `monitor` overlay network, with data on `/mnt/g1/mysql`. Set `MYSQL_ROOT_PASSWORD`, `MYSQL_DATABASE`, `MYSQL_USER`, and `MYSQL_PASSWORD` in the environment, then:

```bash
make deploy
```

## CI

GitHub Actions builds the image on every push and PR, waits for the MariaDB healthcheck to pass, and on `master` pushes a multi-arch (amd64 + arm64) image to Docker Hub.
