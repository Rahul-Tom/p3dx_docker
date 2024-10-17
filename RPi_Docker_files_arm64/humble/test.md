 source /opt/ros/noetic/setup.bash && rosparam load bridge.yaml && source /opt/ros/foxy/setup.bash && ros2 run ros1_bridge parameter_bridge

 roslaunch rosaria_client rosaria_client_launcher.launch _port:=/dev/ttyUSB0

 rosrun sicktoolbox_wrapper sicklms _port:=/dev/ttyUSB1 _baud:=38400 _connect_delay:=30

 ls -l /dev/ttyUSB0
 sudo chmod a+rw /dev/ttyUSB0

 docker exec -it noetic_rosaria bash -c "MobileSim"

docker exec -d noetic_rosaria bash -c "source /opt/ros/noetic/setup.bash && source devel/setup.bash &&rosrun rosaria RosAria"

docker exec -it foxy_bridge bash -c "source /opt/ros/noetic/setup.bash && rosparam load bridge.yaml && source /opt/ros/foxy/setup.bash && ros2 run ros1_bridge parameter_bridge"

docker exec -it noetic_rosaria bash -c "source /opt/ros/indigo/setup.bash && rosrun sicktoolbox_wrapper sicklms _port:=/dev/ttyUSB1 _baud:=38400 _connect_delay:=30"


source /opt/ros/noetic/setup.bash && source /opt/ros/foxy/setup.bash && ros2 run ros1_bridge dynamic_bridge --bridge-all-topics