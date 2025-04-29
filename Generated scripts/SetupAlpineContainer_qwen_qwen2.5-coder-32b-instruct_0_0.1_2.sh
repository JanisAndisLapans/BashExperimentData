docker ps -a
docker start alpine-linux-container
docker inspect alpine-linux-container | grep -A 5 Mounts
docker rm -f alpine-linux-container
docker run -d --name alpine-linux-container -v /usr/alpinedata:/imported alpine tail -f /dev/null