#!/bin/bash

if ! podman pod exists oradbrack; then
  podman pod create --name oradbrack -p 3000:80
fi

# https://docs.oracle.com/en/learn/ol-db-free/index.html#install-oracle-database-free-server-using-podman
# podman volume create oradata
if ! podman secret exists oracle_pwd; then
  echo "Welcome1" | podman secret create oracle_pwd -
fi

podman build -f Dockerfile.rack -t rack-oracledb .
