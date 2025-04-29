mkdir -p /usr/alpinedata
docker run -d --name alpine-linux-container -v /usr/alpinedata:/imported alpine:latest tail -f /dev/null