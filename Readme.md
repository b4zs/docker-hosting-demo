# build and start container

docker build -t=localserver . && docker run --name=localsrv --rm=true -p=50022:22 -p=50080:80 localserver

# login to container through docker

docker exec -it localsrv bash

# login via ssh directly

ssh b4zs@boot2docker -p 50022


