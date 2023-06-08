#!/bin/bash

if ! podman pod exists oradbrack; then
  podman pod create --name oradbrack -p 3000:80
fi

# https://docs.oracle.com/en/learn/ol-db-free/index.html#install-oracle-database-free-server-using-podman
# podman volume create oradata
if ! podman secret exists oracle_pwd; then
  echo "Welcome1" | podman secret create oracle_pwd -
fi

# podman run --pod oradbrack --secret=oracle_pwd -v oradata:/opt/oracle/oradata container-registry.oracle.com/database/free:latest
podman run --pod oradbrack --secret=oracle_pwd container-registry.oracle.com/database/free:latest
