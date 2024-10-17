#!/bin/bash
set -e # setup environment
source $HOME/.bashrc # start in home directory 

cd $HOME/humble_ws/src 
# git clone https://github.com/Rahul-Tom/p3dx_description_ros.git
cd $HOME/humble_ws/
# colcon build
exec bash -i -c $@
# Adding all the necessary ros sourcing

