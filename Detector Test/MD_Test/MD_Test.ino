// Metal detector code
// This is what is programmed onto the UNO

//decalre pins
const byte pin_pulse=A0;  //set pulse pin
const byte pin_cap  =A1;  //set read pin
int ledPin = 13;

//declare variables
const byte npulse = 2;  //number of pulses before measurement
int nmeas=256;          //number if calibration measurements to take
int measurement;        //latest measurement value
int magnum;             //average of measurements during calibration
double sum = 0;         //holds sum to calculate average

//declare functions
void calibrate();
void measure();

void setup() {
  Serial.begin(9600);   //start serial
  while(!Serial);
  //set outputs
  pinMode(ledPin, OUTPUT);    
  pinMode(pin_pulse, OUTPUT); 
  digitalWrite(pin_pulse, LOW);
  
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
    case 's':
      measure();
      break;
    case 'f':
      Serial.write(69);
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

void measure(){
  //reset the capacitor
  pinMode(pin_cap,OUTPUT);
  digitalWrite(pin_cap,LOW);
  delayMicroseconds(500);
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
  int leftmeas = measurement >> 8;
  int rightmeas = measurement;
  Serial.write(leftmeas);
  Serial.write(rightmeas);
}//end of function

//////////////////////End Measure function/////////////////////////
