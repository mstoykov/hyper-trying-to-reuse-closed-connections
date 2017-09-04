#!/usr/bin/python3
import hyper
import socket
import os.path
import requests
from hyper.contrib import HTTP20Adapter

if __name__ == "__main__":
    CRT_PATH = os.path.abspath("./ca.crt")

    old_getaddrinfo = socket.getaddrinfo

    def new_getaddrinfo(host, port, family=0, socktype=0, proto=0, flags=0):
        if host == 'server.example.com':
            return [(2, 1, 6, '', ('172.129.0.5', port))]
        else:
            return old_getaddrinfo(host, port, family, socktype, proto, flags)

    socket.getaddrinfo = new_getaddrinfo
    hyper.tls._context = hyper.tls.init_context(cert_path=CRT_PATH)
    s = requests.Session()
    s.mount('https://server.example.com/', HTTP20Adapter())
    s.verify = CRT_PATH

    for i in range(0, 10):
        resp = s.get('https://server.example.com/', headers={'Host': 'server.example.com'})
        print(resp.status_code)
