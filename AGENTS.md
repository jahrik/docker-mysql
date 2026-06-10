# AGENTS.md

This file provides guidance to AI coding agents when working with code in this repository.

## Purpose

Produces `jahrik/mysql` — a thin wrapper around the official `mariadb` LTS image (multi-arch, amd64 + arm64), kept as its own repo so homelab Swarm stacks can pin a single image name and the version bump happens here.

## Build & Push

```bash
make build   # build locally as jahrik/mysql:latest
make push    # push to Docker Hub
make deploy  # docker stack deploy -c docker-compose.yml mysql
```

## CI

`.github/workflows/build.yml` runs on every push to `master`, every PR, and manual dispatch:
1. Builds the image, starts it with `MARIADB_ROOT_PASSWORD=test`, and polls the official image's `healthcheck.sh --connect --innodb_initialized` until healthy (60s budget).
2. On `master` only, pushes a multi-arch image to Docker Hub using the `DOCKERHUB_USERNAME` / `DOCKERHUB_TOKEN` secrets.

## Image internals

- Base: `docker.io/library/mariadb:11.8` (LTS) — pinned in the `FROM` line; bump there to upgrade
- No modifications beyond an authors label; configuration is all runtime env vars (`MARIADB_*` / legacy `MYSQL_*`)
- `docker-compose.yml` wires it into the external `monitor` overlay network with data at `/mnt/g1/mysql` and credentials from the environment

## Local testing

Docker is not installed on this machine — `docker` is a Podman shim, so `make build` works as-is. Verify with:

```bash
docker run --rm -d --name mysql-test -e MARIADB_ROOT_PASSWORD=test jahrik/mysql:latest
docker exec mysql-test healthcheck.sh --connect --innodb_initialized && echo healthy
docker rm -f mysql-test
```
