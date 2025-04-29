docker inspect alpine-linux-container | grep Mounts -A 10
docker stop alpine-linux-container
docker rm alpine-linux-container
docker run -d --name alpine-linux-container -v /usr/alpinedata:/imported alpine tail -f /dev/null
docker inspect alpine-linux-container | grep Mounts -A 10
mkdir -p /usr/alpinedata
docker restart alpine-linux-container
docker inspect alpine-linux-container | grep Mounts -A 10