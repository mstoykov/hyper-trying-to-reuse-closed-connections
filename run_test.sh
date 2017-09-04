#!/bin/bash
./generate_ca.sh
./generate_certs.sh
docker-compose build
docker-compose run test
docker-compose stop
