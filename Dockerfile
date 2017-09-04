FROM python:3.6.2-alpine

RUN pip3 install hyper requests

ADD ca.crt /tmp/ca.crt
ADD test.py /tmp/test.py
WORKDIR /tmp
