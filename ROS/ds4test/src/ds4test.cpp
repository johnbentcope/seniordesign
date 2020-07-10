#include <ros/ros.h>
#include <ds4_driver/Status.h>
#include <std_msgs/Bool.h>
#include <std_msgs/UInt8.h>

//Global Variables
std_msgs::Bool msg_ds4x;

//Callback Functions
void myCallback(const ds4_driver::Status& message_holder)
{
	if (message_holder.button_cross == 1)
	{	    
		msg_ds4x.data = 1;
	}
	else
	{
		msg_ds4x.data = 0;
	}
}


int main(int argc, char **argv)
{
    ros::init(argc, argv, "ds4_test");
    ros::NodeHandle n;
    ros::Subscriber my_subscriber_object = n.subscribe("status",1,myCallback);
    // Declare a publisher and topic
    ros::Publisher my_publisher_object = n.advertise<std_msgs::Bool>("msg_ds4x", 1);
    ros::Rate naptime(100);
    msg_ds4x.data = 0;

    while (ros::ok())
    {
    my_publisher_object.publish(msg_ds4x);
    ros::spinOnce();
    naptime.sleep();
    }
    return 0;
}
