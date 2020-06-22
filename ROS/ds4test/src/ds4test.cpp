#include <ros/ros.h>
#include "/home/ubuntu/rov/devel/include/ds4_driver/Status.h"

void myCallback(const ds4_driver::Status& message_holder)
{
    ROS_INFO("Is X pressed?: %d",message_holder.button_cross);
}

int main(int argc, char **argv)
{
    ros::init(argc, argv, "ds4_test");
    ros::NodeHandle n;
    ros::Subscriber my_subscriber_object= n.subscribe("status",1,myCallback);
    ros::spin();
    return 0;
}