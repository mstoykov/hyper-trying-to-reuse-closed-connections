# Bug Overview:
hyper does not "forget" about closed connections and when a connection is closed and then a new one
for the same server, port, cert comes an exception is thrown

## How to reproduce:

We use nginx as the server and docker for reproducibility.
You will require docker and docker-compose(fairly recent ones), openssl and bash :). 
NOTICE: The following has only been tested under fedora 25 some options might have to be tweaked on
your machine.

1. clone this repo
2. run ./generate_ca.sh to generate a new CA certificate and key
3. run ./generate_certs.sh to generate new certificates to be used for ssl
4. run docker-compose run test
5. You should get 11 200 on the terminal instead you get 4 and then an error 

You can also just run the run_test.sh script 

## Additional info:
the nginx.conf has an option http2_max_requests which says how many request can be made before the
nginx closes the connection. If it's set to 12 the test will pass. 
By everything I have looked at the connection is really closed and then made a new but hyper thinks
it has an already open connection. This is due to the fact that the defined at
[hyper/contrib.py:33](https://github.com/Lukasa/hyper/blob/669253fe136f28ebe160c9db99257937a1c52a1b/hyper/contrib.py#L33)
`connections` dict is never cleaned up from closed connections. 
