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
const int fwMotor1EnablePin = 6;
const int fwMotor1Pin1 = 62;
const int fwMotor1Pin2 = 63;

bool fwMotor2Forwards;  
int8_t fwMotor2Power;
const int fwMotor2EnablePin = 7;
const int fwMotor2Pin1 = 64;
const int fwMotor2Pin2 = 65;

bool upMotor1Forwards;  
int8_t upMotor1Power;
const int upMotor1EnablePin = 8;
const int upMotor1Pin1 = 66;
const int upMotor1Pin2 = 67;

bool upMotor2Forwards;  
int8_t upMotor2Power;
const int upMotor2EnablePin = 9;
const int upMotor2Pin1 = 68;
const int upMotor2Pin2 = 69;

//Define Node Handle (Same for every code)
ros::NodeHandle nh;

//Define Topics - Publishers
//std_msgs::Bool ds4_x;

//Define Publishers

//Define Subscribers - Callbacks
void messageCbBool( const std_msgs::Bool& msg){
  if (msg.data == 1) 
  {
    digitalWrite(ledPin, HIGH);
  }
  else 
  {
    digitalWrite(ledPin, LOW);
  }
}

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

void messageCbfw2(const std_msgs::Int16& msg)
{
  if (msg.data > 20.0)
  {
    fwMotor2Forwards = 1;
    fwMotor2Power = msg.data;
    powerMotor(fwMotor2EnablePin, fwMotor2Pin1, fwMotor2Pin2, fwMotor2Power, fwMotor2Forwards);
  }
  else if (msg.data < -20)
  {
    fwMotor2Forwards = 0;
    fwMotor2Power = (abs(msg.data));
    powerMotor(fwMotor2EnablePin, fwMotor2Pin1, fwMotor2Pin2, fwMotor2Power, fwMotor2Forwards);
  }
  else
  {
    stopMotor(fwMotor2EnablePin, fwMotor2Pin1, fwMotor2Pin2);
  }
}

void messageCbup1(const std_msgs::Int16& msg)
{
  if (msg.data > 20.0)
  {
    upMotor1Forwards = 1;
    upMotor1Power = msg.data;
    powerMotor(upMotor1EnablePin, upMotor1Pin1, upMotor1Pin2, upMotor1Power, upMotor1Forwards);
  }
  else if (msg.data < -20)
  {
    upMotor1Forwards = 0;
    upMotor1Power = (abs(msg.data));
    powerMotor(upMotor1EnablePin, upMotor1Pin1, upMotor1Pin2, upMotor1Power, upMotor1Forwards);
  }
  else
  {
    stopMotor(upMotor1EnablePin, upMotor1Pin1, upMotor1Pin2);
  }
}

void messageCbup2(const std_msgs::Int16& msg)
{
  if (msg.data > 20.0)
  {
    upMotor2Forwards = 1;
    upMotor2Power = msg.data;
    powerMotor(upMotor2EnablePin, upMotor2Pin1, upMotor2Pin2, upMotor2Power, upMotor2Forwards);
  }
  else if (msg.data < -20)
  {
    upMotor2Forwards = 0;
    upMotor2Power = (abs(msg.data));
    powerMotor(upMotor2EnablePin, upMotor2Pin1, upMotor2Pin2, upMotor2Power, upMotor2Forwards);
  }
  else
  {
    stopMotor(upMotor2EnablePin, upMotor2Pin1, upMotor2Pin2);
  }
}

//Define Subscribers - Topics
ros::Subscriber<std_msgs::Bool>lights("lights", &messageCbBool );
ros::Subscriber<std_msgs::Int16>fw_motor1("fwmotor1", &messageCbfw1 );
ros::Subscriber<std_msgs::Int16>fw_motor2("fwmotor2", &messageCbfw2 );
ros::Subscriber<std_msgs::Int16>up_motor1("upmotor1", &messageCbup1 );
ros::Subscriber<std_msgs::Int16>up_motor2("upmotor2", &messageCbup2 );

void setup() {
  // put your setup code here, to run once:
  pinMode(ledPin, OUTPUT);
  pinMode(fwMotor1EnablePin, OUTPUT);
  pinMode(fwMotor1Pin1, OUTPUT);
  pinMode(fwMotor1Pin2, OUTPUT);
  
  pinMode(fwMotor2EnablePin, OUTPUT);
  pinMode(fwMotor2Pin1, OUTPUT);
  pinMode(fwMotor2Pin2, OUTPUT);

  pinMode(upMotor1EnablePin, OUTPUT);
  pinMode(upMotor1Pin1, OUTPUT);
  pinMode(upMotor1Pin2, OUTPUT);
  
  pinMode(upMotor2EnablePin, OUTPUT);
  pinMode(upMotor2Pin1, OUTPUT);
  pinMode(upMotor2Pin2, OUTPUT);
  
  nh.getHardware()->setBaud(57600);
  //nh.getHardware()->setBaud(9600);
  nh.initNode();
  nh.subscribe(lights);
  nh.subscribe(fw_motor1);
  nh.subscribe(fw_motor2);
  //nh.subscribe(vert_motor1);
  //nh.subscribe(vert_motor2);
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
