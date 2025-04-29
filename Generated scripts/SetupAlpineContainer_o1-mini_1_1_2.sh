docker run -d \
  --name alpine-linux-container \
  --mount type=bind,source=/usr/alpinedata,target=/imported \
  alpine:latest