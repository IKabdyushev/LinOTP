# LinOTP dockerized application #
Go to http://localhost:8080/manage to start  
Admin credentials: admin:admin

## Build image: ##
docker build -t linotp --build-arg "HTTP_PROXY=http://proxy:port" .