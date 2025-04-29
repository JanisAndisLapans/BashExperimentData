docker inspect alpine-linux-container | grep -A 5 Mounts
docker stop alpine-linux-container
docker rm alpine-linux-container
docker run -d --name alpine-linux-container -v /usr/alpinedata:/imported alpine
docker exec -it alpine-linux-container ls /imported