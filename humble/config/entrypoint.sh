#!/bin/bash
set -e # setup environment
source $HOME/.bashrc # start in home directory 
source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash
cd  
exec bash -i -c $@
# Adding all the necessary ros sourcing

