# For deployment in RPi with amr 64 architecture
ARG BASE_IMAGE=arm64v8/ros
ARG ROS_DISTRO=humble
FROM ${BASE_IMAGE}:${ROS_DISTRO}-perception-jammy

ENV DEBIAN_FRONTEND=noninteractive
ARG USER_NAME=tom
ENV HOME=/home/${USER_NAME}

RUN apt-get update && apt-get install -y \
    wget \
    git \
    bash-completion \
    build-essential \
    sudo \
    ros-${ROS_DISTRO}-navigation2 \
    ros-${ROS_DISTRO}-nav2-bringup\
    ros-${ROS_DISTRO}-robot-localization\
    && rm -rf /var/lib/apt/lists/*

# Create the same user as the host itself
ARG UID=1000
ARG GID=1000
RUN addgroup --gid ${GID} ${USER_NAME} && \
    adduser --gecos "ROS User" --disabled-password --uid ${UID} --gid ${GID} ${USER_NAME} && \
    usermod -a -G dialout ${USER_NAME}

# Add sudo permissions
ADD config/99_aptget /etc/sudoers.d/99_aptget
RUN chmod 0440 /etc/sudoers.d/99_aptget && chown root:root /etc/sudoers.d/99_aptget
# Create the workspace
RUN /bin/bash -c "source /opt/ros/humble/setup.bash"
RUN mkdir -p ${HOME}/humble_ws/src
# Choose to run as user
# ENV USER ros
# USER ros 
# # Change HOME environment variable
# ENV HOME /home/${USER} 
# WORKDIR /humble
# RUN mkdir humble
# WORKDIR ${HOME}/humble_ws/bin/bash -c "source source /opt/ros/${ROS_DISTRO}/setup.bash; colcon build --symlink-install"
# WORKDIR ${HOME}/humble_ws 
# RUN /bin/bash -c "source source /opt/ros/humble/setup.bash;colcon build --symlink-install"
# WORKDIR ${HOME}/humble_ws/src
# RUN /bin/bash -c "git clone https://github.com/ros2/teleop_twist_joy.git"
# WORKDIR ${HOME}/humble_ws/src
# RUN /bin/bash -c "git clone https://github.com/ruipaulorocha/p3dx_description_ros.git"
# RUN /bin/bash -c "git clone https://github.com/Rahul-Tom/ros2_p3dx_ws.git"
WORKDIR ${HOME}/humble_ws 
RUN /bin/bash -c "source /opt/ros/humble/setup.bash;colcon build --symlink-install"

# Initialize the catkin workspace
# WORKDIR ${HOME}/humble_ws/src
# WORKDIR ${HOME}/humble_ws/




# Set up environment
COPY config/update_bashrc /sbin/update_bashrc
RUN sudo chmod +x /sbin/update_bashrc && sudo chown ${USER_NAME} /sbin/update_bashrc && sync && /bin/bash -c /sbin/update_bashrc && sudo rm /sbin/update_bashrc

# Change entrypoint to source ~/.bashrc and start in ~
COPY config/entrypoint.sh /ros_entrypoint.sh
RUN sudo chmod +x /ros_entrypoint.sh && sudo chown ${USER_NAME} /ros_entrypoint.sh

# Clean image
RUN sudo apt-get clean && sudo rm -rf /var/lib/apt/lists/*

#RUN /bin/bash -c "source /opt/ros/indigo/setup.bash; roscore"

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
