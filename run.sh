#!/bin/bash

echo "Docker execution started."
echo ${PWD}/Project/Docker

cd ~/Project/Docker && docker-compose up --build  

# sleep 4

# #docker exec -d noetic_rosaria bash -c "MobileSim -m /usr/local/MobileSim/columbia.map -r p3dx"
# sleep 1
# docker exec -d noetic_rosaria bash -c "source /opt/ros/noetic/setup.bash && source devel/setup.bash && rosrun rosaria RosAria"
# docker exec -d indigo_sick bash -c "source /opt/ros/indigo/setup.bash && rosrun sicktoolbox_wrapper sicklms _port:=/dev/ttyUSB1 _baud:=38400" 
# docker exec -d foxy_bridge_container bash -c "source /opt/ros/noetic/setup.bash && rosparam load bridge.yaml && source /opt/ros/foxy/setup.bash && ros2 run ros1_bridge parameter_bridge"
# #docker exec -d foxy_bridge_container bash -c "source /opt/ros/noetic/setup.bash && source /opt/ros/foxy/setup.bash && ros2 run ros1_bridge dynamic_bridge --bridge-all-topics"


# echo "Docker execution finished."
