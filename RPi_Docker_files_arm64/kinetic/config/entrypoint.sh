#!/bin/bash
set -e  # Exit immediately if any command fails

# Source the ROS Noetic environment and workspace setup files
if [ -f /opt/ros/kinetic/setup.bash ]; then
    source /opt/ros/kinetic/setup.bash
else
    echo "ROS setup.bash not found in /opt/ros/kinetic. Exiting."
    exit 1
fi

# Source user environment (optional, if you have custom settings)
source $HOME/.bashrc

# Source workspace if it exists
if [ -f ~/ros_ws/devel/setup.bash ]; then
    source ~/ros_ws/devel/setup.bash
else
    echo "ROS workspace setup.bash not found. Continuing without sourcing workspace."
fi

# Move to home directory
cd $HOME
sleep 3 ## time to turn on ROS Master
#run the sick driver
rosrun sicktoolbox_wrapper sicklms _port:=/dev/ttyUSB1 _baud:=38400

# Wait for any additional passed command, if provided
exec "$@"


