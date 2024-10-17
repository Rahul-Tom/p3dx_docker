# For deployment in RPi with amr 64 architecture
ARG BASE_IMAGE=arm64v8/ros
ARG BASE_TAG=noetic-robot


FROM ${BASE_IMAGE}:${BASE_TAG}

ENV DEBIAN_FRONTEND=noninteractive
ENV HOME=/home/ros

#Installs necessary tools
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
ARG USER=ros
RUN addgroup --gid ${GID} ${USER} && \
    adduser --gecos "ROS User" --disabled-password --uid ${UID} --gid ${GID} ${USER} && \
    usermod -a -G dialout ${USER}

# Add sudo permissions
ADD config/99_aptget /etc/sudoers.d/99_aptget
RUN chmod 0440 /etc/sudoers.d/99_aptget && chown root:root /etc/sudoers.d/99_aptget

# Create the workspace
RUN mkdir -p ${HOME}/ros_ws/src
# Initialize the catkin workspace
WORKDIR ${HOME}/ros_ws/src
RUN /bin/bash -c "source /opt/ros/noetic/setup.bash; catkin_init_workspace"
# Build the workspace
WORKDIR ${HOME}/ros_ws
RUN /bin/bash -c "source /opt/ros/noetic/setup.bash; catkin_make"

#cloing rosaria
WORKDIR ${HOME}/ros_ws/src
RUN /bin/bash -c "git clone https://github.com/amor-ros-pkg/rosaria.git"
WORKDIR ${HOME}/ros_ws/src
RUN /bin/bash -c "git clone https://github.com/reedhedges/AriaCoda.git"
WORKDIR ${HOME}/ros_ws/src/AriaCoda
RUN /bin/bash -c "make"
WORKDIR ${HOME}/ros_ws/src/AriaCoda
RUN /bin/bash -c "sudo make install"
WORKDIR ${HOME}/ros_ws/src/
# RUN /bin/bash -c "git clone https://github.com/pengtang/rosaria_client.git" #incompatbile with arm64
WORKDIR ${HOME}/ros_ws/
RUN /bin/bash -c "source devel/setup.bash; catkin_make"
WORKDIR ${HOME}/ros_ws/
RUN /bin/bash -c "source /opt/ros/noetic/setup.bash; catkin_make"

#Installing the MobileSim (Simulator)
COPY mobilesim.deb /noetic/mobilesim.deb
RUN dpkg -i /noetic/mobilesim.deb || apt-get install -f -y

# Set up environment
COPY config/update_bashrc /sbin/update_bashrc
RUN sudo chmod +x /sbin/update_bashrc && sudo chown ros /sbin/update_bashrc && sync && /bin/bash -c /sbin/update_bashrc && sudo rm /sbin/update_bashrc

# Change entrypoint to source ~/.bashrc and start in ~
COPY config/entrypoint.sh /ros_entrypoint.sh
RUN sudo chmod +x /ros_entrypoint.sh && sudo chown ros /ros_entrypoint.sh

# Clean image
RUN sudo apt-get clean && sudo rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
