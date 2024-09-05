# Dockerfile.ros_noetic

FROM osrf/ros:noetic-desktop

WORKDIR /noetic

# Install necessary dependencies, including catkin and doxygen
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    sudo \
    ros-noetic-catkin \
    doxygen \
    && rm -rf /var/lib/apt/lists/*
   

# Source ROS setup and set up catkin workspace
RUN /bin/bash -c "source /opt/ros/noetic/setup.bash && \
    mkdir -p /noetic/catkin_ws/src && \
    cd /noetic/catkin_ws/src && \
    catkin_init_workspace && \
    cd /noetic/catkin_ws && \
    catkin_make"

# Clone ROSARIA and AriaCoda, build them, and install
RUN /bin/bash -c "source /noetic/catkin_ws/devel/setup.bash && \
    cd /noetic/catkin_ws/src && \
    git clone https://github.com/amor-ros-pkg/rosaria.git && \
    git clone https://github.com/reedhedges/AriaCoda.git && \
    cd /noetic/catkin_ws/src/AriaCoda && make && \
    sudo make install && \
    cd /noetic/catkin_ws && catkin_make"

# Install MobileSim from the .deb package located in /noetic
COPY mobilesim.deb /noetic/mobilesim.deb
RUN dpkg -i /noetic/mobilesim.deb || apt-get install -f -y

# Add MobileSim to the PATH
RUN ln -s /usr/local/bin/MobileSim /usr/bin/MobileSim

# Source the workspace setup in every new shell session
RUN echo "source /noetic/catkin_ws/devel/setup.bash" >> ~/.bashrc

SHELL ["/bin/bash", "-c"]

ENTRYPOINT ["/bin/bash"]
