#!/bin/bash
./generate_ca.sh
./generate_certs.sh
docker-compose run test
