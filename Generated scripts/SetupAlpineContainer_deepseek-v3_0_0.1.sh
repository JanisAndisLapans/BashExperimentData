# Create the directory on the host if it doesn't exist
mkdir -p /usr/alpinedata

# Run the Alpine container with the volume mount
docker run -d --name alpine-linux-container -v /usr/alpinedata:/imported alpine:latest tail -f /dev/null