# LinOTP dockerized application #  
Go to http://localhost:8080/manage to start  
Admin credentials: admin:admin

## Build image: ##  
docker build -t linotp --build-arg "HTTP_PROXY=http://proxy:port" .  

## Issues: ##  
Version 2.10 has bug with self-service login? Version 2.9 is OK
https://github.com/LinOTP/LinOTP/issues/93