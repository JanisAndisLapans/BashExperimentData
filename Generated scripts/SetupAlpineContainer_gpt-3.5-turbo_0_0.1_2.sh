# Since the directory already exists, we can skip creating it and try running the container again
docker run -d -v /usr/alpinedata:/imported --name alpine-linux-container alpine