#!/bin/bash

REBUILD=0

# Parse options
while getopts 'r' opt; do
  case $opt in
    r) REBUILD=1 ;;
    *) echo 'Error in command line parsing' >&2
       exit 1
    ;;
  esac
done

# Shift arguments so that $1 points to the first non-option argument
shift "$((OPTIND - 1))"

# Check if the ROS distribution argument is provided
if [ $# -eq 0 ]; then
  echo 'Specify the ROS distribution to use: e.g., melodic, noetic...'
  exit 1
fi

# Set up variables
BASE_IMAGE=osrf/ros
BASE_TAG=$1

# Pull the specified base image
docker pull ${BASE_IMAGE}:${BASE_TAG}

# Custom variables to avoid conflict with built-ins
DOCKER_UID="$(id -u $USER)"
DOCKER_GID="$(id -g $USER)"
NAME=ros_ws2

# Build Docker image
if [ "$REBUILD" -eq 1 ]; then
  docker build \
    --no-cache \
    --build-arg BASE_IMAGE=${BASE_IMAGE} \
    --build-arg BASE_TAG=${BASE_TAG} \
    --build-arg UID=${DOCKER_UID} \
    --build-arg GID=${DOCKER_GID} \
    -t ${NAME}:${BASE_TAG} .
else
  docker build \
    --build-arg BASE_IMAGE=${BASE_IMAGE} \
    --build-arg BASE_TAG=${BASE_TAG} \
    --build-arg UID=${DOCKER_UID} \
    --build-arg GID=${DOCKER_GID} \
    -t ${NAME}:${BASE_TAG} .
fi
echo "Running Docker container with X11 forwarding..."
xhost +local:docker

# docker run -it --rm \
#     -e DISPLAY=$DISPLAY \
#     -v /tmp/.X11-unix:/tmp/.X11-unix \
#     "${IMAGE_NAME}:${TAG}" \
#     /bin/bash