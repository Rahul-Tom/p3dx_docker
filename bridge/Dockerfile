FROM osrf/ros:foxy-ros1-bridge

#ADD ./ros_bridge_entry.sh /
COPY /entrypoint.sh /ros_bridge_entry.sh
#
WORKDIR /ros_bridge
ENTRYPOINT [ "/ros_bridge_entry.sh" ]
CMD [ "bash" ]