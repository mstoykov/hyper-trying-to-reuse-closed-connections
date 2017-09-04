#!/bin/bash
set -e
set -x

openssl genrsa -out star.example.com.key 2048
openssl req -new -out star.example.com.req \
    -key star.example.com.key -config certificate.req


openssl x509 -req -in star.example.com.req -CA ca.crt -CAkey ca.key -days 4 \
    -out star.example.com.crt -extensions v3_req -extfile certificate.req \
    -set_serial `date +%s`

openssl dhparam -outform PEM -out dhparam.pem 1024
