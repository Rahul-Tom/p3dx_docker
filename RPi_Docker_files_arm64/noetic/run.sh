#!/bin/bash

NAME=ros_ws2 # Replace with the name of your image
TAG=noetic-desktop-full # The tag of your built image

# Create a shared volume to store the ros_ws
mkdir -p source

docker volume create --driver local \
    --opt type="none" \
    --opt device="${PWD}/source/" \
    --opt o="bind" \
    "${NAME}_src_vol"

# Allow connections to the X server
xhost +

# Run the Docker container with access to external devices
docker run \
    --net=host \
    --privileged \
    -it \
    --rm \
    --volume="${NAME}_src_vol:/home/ros/ros_ws/src:rw" \
    --env="DISPLAY=$DISPLAY" \
    --volume="${PWD}/source:/root/.NAME" \
    --volume="/dev/bus/usb:/dev/bus/usb" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix" \
    "${NAME}:${TAG}"
