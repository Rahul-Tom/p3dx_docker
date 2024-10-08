#!/bin/bash
set -e # setup environment
source $HOME/.bashrc # start in home directory 
cd  
roscore &
exec bash -i -c $@
# Adding all the necessary ros sourcing
echo "" >> ~/.bashrc
echo "## ROS" >> ~/.bashrc
echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc
echo "source ~/ros_ws/devel/setup.bash" >> ~/.bashrc