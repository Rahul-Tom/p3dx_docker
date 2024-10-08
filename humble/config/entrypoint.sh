#!/bin/bash
set -e # setup environment
source $HOME/.bashrc # start in home directory 
source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash
cd  
exec bash -i -c $@
# Adding all the necessary ros sourcing
echo "" >> ~/.bashrc
echo "## ROS" >> ~/.bashrc
echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc
echo "source /home/ros/humble_ws/install/setup.bash" >> ~/.bashrc
