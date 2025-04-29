mkdir -p /usr/alpinedata
chmod 755 /usr/alpinedata
docker run -it --name alpine-linux-container -v /usr/alpinedata:/imported alpine sh
ls /imported
exit
docker inspect alpine-linux-container | grep -A 5 Mounts