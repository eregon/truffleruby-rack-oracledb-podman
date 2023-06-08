#!/bin/bash

# podman run --pod oradbrack --secret=oracle_pwd -v oradata:/opt/oracle/oradata container-registry.oracle.com/database/free:latest
podman run --pod oradbrack --secret=oracle_pwd container-registry.oracle.com/database/free:latest
