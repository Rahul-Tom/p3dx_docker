# For deployment in RPi with amr 64 architecture
ARG BASE_IMAGE=arm64v8/ros
ARG BASE_TAG=kinetic-robot
l

FROM ${BASE_IMAGE}:${BASE_TAG}

ENV DEBIAN_FRONTEND=noninteractive
ENV HOME=/home/ros


RUN apt-get update && apt-get install -y \
    wget \
    git \
    bash-completion \
    build-essential \
    sudo \
    doxygen \
    && rm -rf /var/lib/apt/lists/*

# Create the same user as the host itself
ARG UID=1000
ARG GID=1000
RUN addgroup --gid ${GID} ros && \
    adduser --gecos "ROS User" --disabled-password --uid ${UID} --gid ${GID} ros && \
    usermod -a -G dialout ros

# Add sudo permissions
ADD config/99_aptget /etc/sudoers.d/99_aptget
RUN chmod 0440 /etc/sudoers.d/99_aptget && chown root:root /etc/sudoers.d/99_aptget

# Create the workspace
RUN mkdir -p ${HOME}/ros_ws/src

# Initialize the catkin workspace
WORKDIR ${HOME}/ros_ws/src
#RUN /bin/bash -c "source /opt/ros/kinetic/setup.bash; catkin_init_workspace; catkin_init_workspace"
RUN /bin/bash -c "source /opt/ros/kinetic/setup.bash; catkin_init_workspace"


# Build the workspace
WORKDIR ${HOME}/ros_ws
RUN /bin/bash -c "source /opt/ros/kinetic/setup.bash; catkin_make"


#cloning sick toolbox and wrapper
WORKDIR ${HOME}/ros_ws/src
RUN /bin/bash -c "git clone https://github.com/SantoshBanisetty/sicktoolbox.git"
WORKDIR ${HOME}/ros_ws/src
RUN /bin/bash -c "git clone https://github.com/ros-drivers/sicktoolbox_wrapper.git"
WORKDIR ${HOME}/ros_ws/
RUN /bin/bash -c "source devel/setup.bash; catkin_make"
WORKDIR ${HOME}/ros_ws/
RUN /bin/bash -c "source /opt/ros/kinetic/setup.bash; catkin_make"



# Set up environment
COPY config/update_bashrc /sbin/update_bashrc
RUN sudo chmod +x /sbin/update_bashrc && sudo chown ros /sbin/update_bashrc && sync && /bin/bash -c /sbin/update_bashrc && sudo rm /sbin/update_bashrc

# Change entrypoint to source ~/.bashrc and start in ~
COPY config/entrypoint.sh /ros_entrypoint.sh
RUN sudo chmod +x /ros_entrypoint.sh && sudo chown ros /ros_entrypoint.sh

# Clean image
RUN sudo apt-get clean && sudo rm -rf /var/lib/apt/lists/*

#RUN /bin/bash -c "source /opt/ros/kinetic/setup.bash; roscore"

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
