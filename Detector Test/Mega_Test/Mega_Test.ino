int ledPin = 13;

void setup() {
  Serial.begin(9600);       //Start serial communication at 9600bps
  while(!Serial);
  Serial1.begin(9600);       //Start serial communication at 9600bps
  while(!Serial1);
  pinMode(ledPin, OUTPUT);
}

void loop() {
  //Tell detector to measure coil 1
  Serial1.print('a');
  
  while(Serial1.available()<1) //Wait for 1 bytes to arrive
  {
    //do nothing
  } //End While
  int magnum1=Serial1.read();  //Read byte
  
  while(Serial1.available()<1) //Wait for 1 bytes to arrive
  {
    //do nothing
  } //End While
  int magnum2=Serial1.read();  //Read byte
  
  Serial.println("2 bytes recieved");
  Serial.print("byte1: "); 
  Serial.println(magnum1);
  Serial.print("byte2: ");
  Serial.println(magnum2);

  
  int magnum = (magnum1 << 8) + magnum2;
  Serial.print("measurement recieved: ");
  Serial.println(magnum);
  Serial.println();

  //Tell detector to measure coil 2 xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
  Serial1.print('b');
  
  while(Serial1.available()<1) //Wait for 1 bytes to arrive
  {
    //do nothing
  } //End While
  magnum1=Serial1.read();  //Read byte
  
  while(Serial1.available()<1) //Wait for 1 bytes to arrive
  {
    //do nothing
  } //End While
  magnum2=Serial1.read();  //Read byte
  
  Serial.println("2 bytes recieved");
  Serial.print("byte1: "); 
  Serial.println(magnum1);
  Serial.print("byte2: ");
  Serial.println(magnum2);

  
  magnum = (magnum1 << 8) + magnum2;
  Serial.print("measurement recieved: ");
  Serial.println(magnum);
  Serial.println();


  //Tell detector to measure coil 3 xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx 
  Serial1.print('c');
  
  while(Serial1.available()<1) //Wait for 1 bytes to arrive
  {
    //do nothing
  } //End While
  magnum1=Serial1.read();  //Read byte
  
  while(Serial1.available()<1) //Wait for 1 bytes to arrive
  {
    //do nothing
  } //End While
  magnum2=Serial1.read();  //Read byte
  
  Serial.println("2 bytes recieved");
  Serial.print("byte1: "); 
  Serial.println(magnum1);
  Serial.print("byte2: ");
  Serial.println(magnum2);

  
  magnum = (magnum1 << 8) + magnum2;
  Serial.print("measurement recieved: ");
  Serial.println(magnum);
  Serial.println();
  Serial.print("xxxxxxxxxxxxxxxxxxx end of 3 measures xxxxxxxxxxxxxxxxxxxx ");
  Serial.println();
}//End Loop
