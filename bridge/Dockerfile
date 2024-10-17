# For development in Laptop with amd64 architecture
ARG BASE_IMAGE=osrf/ros
ARG BASE_TAG=foxy-ros1-bridge
FROM ${BASE_IMAGE}:${BASE_TAG}

#ADD ./ros_bridge_entry.sh /
COPY /entrypoint.sh /ros_bridge_entry.sh
#
WORKDIR /ros_bridge
ENTRYPOINT [ "/ros_bridge_entry.sh" ]
CMD [ "bash" ]