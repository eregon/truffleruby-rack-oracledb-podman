#!/bin/bash

echo
echo 'See website at http://127.0.0.1:3000/'
echo
podman run --rm -it --pod oradbrack rack-oracledb
