Add these files to src directory in your catkin workspace, then while in the directory for that workspace enter
catkin_make

Before starting roscore or any nodes run these commands to use ethernet connection:
Jetson:
export ROS_IP=192.168.0.3

Pi:
export ROS_IP=192.168.0.2
export ROS_MASTER_URI=http://192.168.0.3:11311/

Running System:
Jetson:
roscore
rosrun ds4test ds4test
rosrun rosserial_python serial_node.py _port:=/dev/ttyACM0 _baud:=57600

Pi:
rosrun ds4_driver ds4_driver_node.py

TODO: Script all of this
