// On my UNO, I'm using these
#define MSHCLK 8
#define MSHENA 12
#define MSHDTA 2

#define MA_ENA 3
#define MB_ENA 5
#define MC_ENA 6
#define MD_ENA 9

#define MA_IN1 0x80;
#define MA_IN2 0x40;
#define MB_IN1 0x20;
#define MB_IN2 0x10;
#define MC_IN1 0x08;
#define MC_IN2 0x04;
#define MD_IN1 0x02;
#define MD_IN2 0x01;

#define MA_CLR (MA_IN1 | MA_IN2)
#define MB_CLR (MB_IN1 | MB_IN2)
#define MC_CLR (MC_IN1 | MC_IN2)
#define MD_CLR (MD_IN1 | MD_IN2)

#define MA_FWD MA_IN1
#define MB_FWD MB_IN1
#define MC_FWD MC_IN1
#define MD_FWD MD_IN1

#define MA_REV MA_IN2
#define MB_REV MB_IN2
#define MC_REV MC_IN2
#define MD_REV MD_IN2

int toggle = 0;
char payload = 0x55;

void setup() {
  pinMode(MSHCLK, OUTPUT);
  pinMode(MSHENA, OUTPUT);
  pinMode(MSHDTA, OUTPUT);
  pinMode(MA_ENA, OUTPUT);
  pinMode(MB_ENA, OUTPUT);
  pinMode(MC_ENA, OUTPUT);
  pinMode(MD_ENA, OUTPUT);
}

void loop() {

  // Loop through the four possible motor control things and rev the ENA pin

  for(int m = 1; m < 3; m++)
  {

    payload = 0;
    payload = ((m & 3) << 4) | (m&3);

    
    for(int i = 0; i <= 8; i++){
      digitalWrite(MSHENA, LOW);
      shiftOut(MSHDTA, MSHCLK, LSBFIRST, payload);
      digitalWrite(MSHENA, HIGH);
    }
    int i;
    for(i = 0; i < 256; i++)
    {
      analogWrite(MA_ENA, i);
      analogWrite(MC_ENA, i);
      delay(15);
    }
    for(; i >= 50; i--)
    {
      analogWrite(MA_ENA, i);
      analogWrite(MC_ENA, i);
      delay(15);
    }
    for(i = 50; i < 150; i++)
    {
      analogWrite(MA_ENA, i);
      analogWrite(MC_ENA, i);
      delay(15);
    }
    for(; i >= 50; i--)
    {
      analogWrite(MA_ENA, i);
      analogWrite(MC_ENA, i);
      delay(15);
    }
    for(i = 50; i < 150; i++)
    {
      analogWrite(MA_ENA, i);
      analogWrite(MC_ENA, i);
      delay(15);
    }
    for(; i >= 50; i--)
    {
      analogWrite(MA_ENA, i);
      analogWrite(MC_ENA, i);
      delay(15);
    }
    for(i = 50; i < 150; i++)
    {
      analogWrite(MA_ENA, i);
      analogWrite(MC_ENA, i);
      delay(15);
    }
    for(; i >= 0; i--)
    {
      analogWrite(MA_ENA, i);
      analogWrite(MC_ENA, i);
      delay(15);
    }
    
    delay(500);
  }
  
}
