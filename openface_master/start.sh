# # Give the authority to /dev/video0
sudo chmod 777 /dev/video0

# # Run openface2_ros
roscore &
rosrun usb_cam usb_cam_node &
roslaunch openface2_ros openface2_ros.launch
