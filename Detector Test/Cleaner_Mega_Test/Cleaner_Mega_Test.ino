int ledPin = 13;
int x = 0;
int y = 0;
int z = 0;
unsigned long time = 0;

void setup() {
  Serial.begin(9600);       //Start serial communication at 9600bps
  while(!Serial);
  Serial2.begin(9600);       //Start serial communication at 9600bps
  while(!Serial2);
  pinMode(ledPin, OUTPUT);
}

void loop() {
  while(x < 10 && y < 10 && z <10){
    //Tell detector to measure coil 1
    Serial2.print('a');
    while(Serial2.available()<1) //Wait for 1 bytes to arrive
    {
      if (millis()-time > 100)
      {
        x++;
        break;
      }
    } //End While
    int magnum1=Serial2.read();  //Read byte
    
    while(Serial2.available()<1) //Wait for 1 bytes to arrive
    {
      if (millis()-time > 100)
      {
        x++;
        break;
      }
    } //End While
    int magnum2=Serial2.read();  //Read byte

    int magnum = (magnum1 << 8) + magnum2;
    Serial.print("Coil 1: ");
    Serial.print(magnum);
    
  
    //Tell detector to measure coil 2 xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    Serial2.print('b');
    
    while(Serial2.available()<1) //Wait for 1 bytes to arrive
    {
      if (millis()-time > 100)
      {
        y++;
        break;
      }
    } //End While
    magnum1=Serial2.read();  //Read byte
    
    while(Serial2.available()<1) //Wait for 1 bytes to arrive
    {
      if (millis()-time > 100)
      {
        y++;
        break;
      }
    } //End While
    magnum2=Serial2.read();  //Read byte

    magnum = (magnum1 << 8) + magnum2;
    Serial.print("    Coil 2: ");
    Serial.print(magnum);

    //Tell detector to measure coil 3 xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx 
    Serial2.print('c');
    
    while(Serial2.available()<1) //Wait for 1 bytes to arrive
    {
      if (millis()-time > 100)
      {
        z++;
        break;
      }
    } //End While
    magnum1=Serial2.read();  //Read byte
    
    while(Serial2.available()<1) //Wait for 1 bytes to arrive
    {
      if (millis()-time > 100)
      {
        z++;
        break;
      }
    } //End While
    magnum2=Serial2.read();  //Read byte
 
    magnum = (magnum1 << 8) + magnum2;
    Serial.print("    Coil 3: ");
    Serial.print(magnum);
    Serial.println();
  }//End While
  
  //serial timeout on one or more coil measurements
  Serial.println("coil measurement timeout...");
  Serial.println("X: " + x);
  Serial.println("Y: " + y);
  Serial.println("Z: " + z);
  delay(1000);
}//End Loop
