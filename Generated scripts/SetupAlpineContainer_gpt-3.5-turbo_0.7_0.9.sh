# Create a volume on the host
mkdir /usr/alpinedata

# Run the Alpine docker container with the volume mounted
docker run -d --name alpine-linux-container -v /usr/alpinedata:/imported alpine