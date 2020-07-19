// Metal detector code
// This is what is programmed onto the UNO

//decalre pulse and cap pins
const byte pin_pulse1 = A0;
const byte pin_cap1   = A1;
const byte pin_pulse2 = A2;  
const byte pin_cap2   = A3;  
const byte pin_pulse3 = A4;  
const byte pin_cap3   = A5;
int ledPin = 7;

//declare variables
const byte npulse = 2;  //number of pulses before measurement
int nmeas=256;          //number if calibration measurements to take
int measurement;        //latest measurement value
int magnum;             //average of measurements during calibration
double sum = 0;         //holds sum to calculate average
char start;

//declare functions
void calibrate();
void measure1();
void measure2();
void measure3();

void setup() {
  Serial.begin(9600);   //start serial
  while(!Serial);
  //set outputs
  pinMode(ledPin, OUTPUT);    
  pinMode(pin_pulse1, OUTPUT); 
  digitalWrite(pin_pulse1, LOW);
  pinMode(pin_pulse2, OUTPUT); 
  digitalWrite(pin_pulse2, LOW);
  pinMode(pin_pulse3, OUTPUT); 
  digitalWrite(pin_pulse3, LOW);
}//end of function

/////////////////////End Setup function//////////////////////////////

void loop() {
  while(Serial.available()<1) //Wait for 1 bytes to arrive
  {
    //do nothing
  } //End While
 
  //get message
  char canidetect = Serial.read();
  switch (canidetect){
    case 'a':
      measure1();
      break;
    case 'b':
      measure2();
      break;
    case 'c':
      measure3();
      break;
    default:
      break;
  }//end switch
  Serial.flush();
}//end of function
  
////////////////////End Loop function/////////////////////////////

/*void calibrate(){
  //calibration process
    for (int imeas=0; imeas<nmeas; imeas++){
    //reset cap
    pinMode(pin_cap,OUTPUT);
    digitalWrite(pin_cap,LOW);
    delayMicroseconds(20);
    pinMode(pin_cap,INPUT);
    //apply pulses
    for (int ipulse = 0; ipulse < npulse; ipulse++) {
      digitalWrite(pin_pulse,HIGH); //takes 3.5 microseconds
      delayMicroseconds(3);
      digitalWrite(pin_pulse,LOW);  //takes 3.5 microseconds
      delayMicroseconds(3);
    }
    //read the charge on the capacitor
    measurement = analogRead(pin_cap); //takes 13x8=104 microseconds
    Serial.print("Measurement "); Serial.print(imeas+1); Serial.print(" is: "); Serial.println(measurement);
    sum += measurement;
  }
  //print sum
  Serial.print("Sum is: ");
  Serial.println(sum); 
  
  //print average
  magnum = sum/nmeas;
  //Serial.print("Magic Number is: ");
  //Serial.println(magnum);
  
  //reset sum for next calibration
  sum = 0; 
}//end of function
*/
///////////////////////End Calibrate function///////////////////////////

void measure1(){
  //reset the capacitor
  pinMode(pin_cap1,OUTPUT);
  digitalWrite(pin_cap1,LOW);
  delayMicroseconds(500);
  pinMode(pin_cap1,INPUT);
  //apply pulses
  for (int ipulse = 0; ipulse < npulse; ipulse++) {
    digitalWrite(pin_pulse1,HIGH); //takes 3.5 microseconds
    delayMicroseconds(3);
    digitalWrite(pin_pulse1,LOW);  //takes 3.5 microseconds
    delayMicroseconds(3);
  }
  //read the charge on the capacitor
  measurement = analogRead(pin_cap1); //takes 13x8=104 microseconds
  unsigned int leftmeas = measurement >> 8;
  unsigned int rightmeas = measurement;
  Serial.write(leftmeas);
  Serial.write(rightmeas);
  pinMode(pin_cap1,OUTPUT);
  digitalWrite(pin_cap1,LOW);
}//end of function

//////////////////////End Measure1 function/////////////////////////
void measure2(){
  //reset the capacitor
  pinMode(pin_cap2,OUTPUT);
  digitalWrite(pin_cap2,LOW);
  delayMicroseconds(500);
  pinMode(pin_cap2,INPUT);
  //apply pulses
  for (int ipulse = 0; ipulse < npulse; ipulse++) {
    digitalWrite(pin_pulse2,HIGH); //takes 3.5 microseconds
    delayMicroseconds(3);
    digitalWrite(pin_pulse2,LOW);  //takes 3.5 microseconds
    delayMicroseconds(3);
  }
  //read the charge on the capacitor
  measurement = analogRead(pin_cap2); //takes 13x8=104 microseconds
  unsigned int leftmeas = measurement >> 8;
  unsigned int rightmeas = measurement;
  Serial.write(leftmeas);
  Serial.write(rightmeas);
  pinMode(pin_cap2,OUTPUT);
  digitalWrite(pin_cap2,LOW);
}//end of function

//////////////////////End Measure2 function/////////////////////////
void measure3(){
  //reset the capacitor
  pinMode(pin_cap3,OUTPUT);
  digitalWrite(pin_cap3,LOW);
  delayMicroseconds(500);
  pinMode(pin_cap3,INPUT);
  //apply pulses
  for (int ipulse = 0; ipulse < npulse; ipulse++) {
    digitalWrite(pin_pulse3,HIGH); //takes 3.5 microseconds
    delayMicroseconds(3);
    digitalWrite(pin_pulse3,LOW);  //takes 3.5 microseconds
    delayMicroseconds(3);
  }
  //read the charge on the capacitor
  measurement = analogRead(pin_cap3); //takes 13x8=104 microseconds
  unsigned int leftmeas = measurement >> 8;
  unsigned int rightmeas = measurement;
  Serial.write(leftmeas);
  Serial.write(rightmeas);
  pinMode(pin_cap3,OUTPUT);
  digitalWrite(pin_cap3,LOW);
}//end of function

//////////////////////End Measure3 function/////////////////////////
