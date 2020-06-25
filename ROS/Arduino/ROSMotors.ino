/*
 * Ros Motor Code
 */
#include <ros.h>
#include <std_msgs/Bool.h>
#include <std_msgs/Int16.h>

const int ledPin =  LED_BUILTIN;// the number of the LED pin

//Motor Definitions
// Forward Motor 1
bool fwMotor1Forwards;  
int8_t fwMotor1Power;
const int fwMotor1EnablePin = 2;
const int fwMotor1Pin1 = 28;
const int fwMotor1Pin2 = 30;


//Define Node Handle (Same for every code)
ros::NodeHandle nh;

//Define Topics - Publishers
//std_msgs::Bool ds4_x;

//Define Publishers

//Define Subscribers - Callbacks
void messageCbfw1(const std_msgs::Int16& msg)
{
  if (msg.data > 20.0)
  {
    fwMotor1Forwards = 1;
    fwMotor1Power = msg.data;
    powerMotor(fwMotor1EnablePin, fwMotor1Pin1, fwMotor1Pin2, fwMotor1Power, fwMotor1Forwards);
  }
  else if (msg.data < -20)
  {
    fwMotor1Forwards = 0;
    fwMotor1Power = (abs(msg.data));
    powerMotor(fwMotor1EnablePin, fwMotor1Pin1, fwMotor1Pin2, fwMotor1Power, fwMotor1Forwards);
  }
  else
  {
    stopMotor(fwMotor1EnablePin, fwMotor1Pin1, fwMotor1Pin2);
  }
}

//Define Subscribers - Topics
ros::Subscriber<std_msgs::Int16>fw_motor1("fw_motor1", &messageCbfw1 );

void setup() {
  // put your setup code here, to run once:
  pinMode(ledPin, OUTPUT);
  pinMode(fwMotor1EnablePin, OUTPUT);
  pinMode(fwMotor1Pin1, OUTPUT);
  pinMode(fwMotor1Pin2, OUTPUT);
  nh.getHardware()->setBaud(57600);
  nh.initNode();
  nh.subscribe(fw_motor1);
}

void loop() {
  // put your main code here, to run repeatedly:
  
  nh.spinOnce();
  delay(1);
}

void powerMotor(int enablePin, int pin1, int pin2, int motorPower, bool isMotorForward)
{
  //motorPower = map(motorPower, 0, 127, 0, 255);
  if (isMotorForward) 
  {
    digitalWrite(pin1, HIGH);
    digitalWrite(pin2, LOW);
    analogWrite(enablePin, motorPower);
  }
  else
  {
    digitalWrite(pin1, LOW);
    digitalWrite(pin2, HIGH);
    analogWrite(enablePin, motorPower);
  }
}

void stopMotor(int enablePin, int pin1, int pin2)
{
    digitalWrite(pin1,LOW);
    digitalWrite(pin2,LOW);
    analogWrite(enablePin, LOW);
}
