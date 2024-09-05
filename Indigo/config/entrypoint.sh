#!/bin/bash
set -e # setup environment
source $HOME/.bashrc # start in home directory 
cd  
exec bash -i -c $@
# Adding all the necessary ros sourcing
echo "" >> ~/.bashrc
echo "## ROS" >> ~/.bashrc
echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc
echo "source /home/ros/ros_ws/install/setup.bash" >> ~/.bashrc
