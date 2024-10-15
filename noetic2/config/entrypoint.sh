#!/bin/bash
set -e  # Exit immediately if any command fails

# Source the ROS Noetic environment and workspace setup files
if [ -f /opt/ros/noetic/setup.bash ]; then
    source /opt/ros/noetic/setup.bash
else
    echo "ROS setup.bash not found in /opt/ros/noetic. Exiting."
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

# Start ROS core in the background
roscore &
roscore_pid=$!

# Wait for roscore to fully start
sleep 5

# Start MobileSim in the background
# MoleSim -m /usr/local/MobileSim/columbia.map -r p3dx &
# mobilesim_pid=$!

# Wait for MobileSim to start
sleep 2

# Start RosAria node
rosrun rosaria RosAria _port:=/dev/ttyUSB0


# Wait for any additional passed command, if provided
exec "$@"

# Ensure that when the script exits, both roscore and MobileSim are killed
# trap 'kill -TERM $roscore_pid $mobilesim_pid' EXIT
trap 'kill -TERM $roscore_pid pid' EXIT
