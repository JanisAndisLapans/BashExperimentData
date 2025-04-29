# Check the container ID
CONTAINER_ID=$(docker ps -aqf "name=alpine-linux-container")

# Stop and remove the container
docker stop $CONTAINER_ID
docker rm $CONTAINER_ID

# Create the volume on the host if it doesn't exist
if [ ! -d "/usr/alpinedata" ]; then
    mkdir /usr/alpinedata
fi

# Run the Alpine docker container with the volume mounted
docker run -d --name alpine-linux-container -v /usr/alpinedata:/imported alpine