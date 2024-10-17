#!/bin/bash

set -e

sleep 3
source /opt/ros/noetic/setup.bash && rosparam load bridge.yaml && source /opt/ros/foxy/setup.bash && ros2 run ros1_bridge parameter_bridge

echo "Provided arguments: $@"

exec $@