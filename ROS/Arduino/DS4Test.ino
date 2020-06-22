/*
 * Turns on built in LED when the X button is held down on DS4 controller
 */
#include <ros.h>
#include <std_msgs/Bool.h>

const int ledPin =  LED_BUILTIN;// the number of the LED pin

//Define Node Handle (Same for every code)
ros::NodeHandle nh;

//Define Topics - Publishers
//std_msgs::Bool ds4_x;

//Define Publishers

//Define Subscribers - Callbacks
void messageCbBool( const std_msgs::Bool& msg){
  //nh.loginfo( "Received bool msg");
  if (msg.data == 1) 
  {
    digitalWrite(ledPin, HIGH);
  }
  else 
  {
    digitalWrite(ledPin, LOW);
  }
}

//Define Subscribers - Topics
ros::Subscriber<std_msgs::Bool> sub("msg_ds4x", &messageCbBool );

void setup() {
  // put your setup code here, to run once:
  pinMode(ledPin, OUTPUT);
  nh.initNode();
  nh.getHardware()->setBaud(9600);
  nh.subscribe(sub);

}

void loop() {
  // put your main code here, to run repeatedly:
  nh.spinOnce();
  delay(1);
}
