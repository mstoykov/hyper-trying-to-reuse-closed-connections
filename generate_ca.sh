#!/bin/bash

set -e
set -x 

openssl genrsa -out ca.key 4096

openssl req -new -x509 -days 4 -key ca.key -out ca.crt \
    -subj '/C=US/ST=US/L=US/O=test/OU=test/emailAddress=test@example.com/'
