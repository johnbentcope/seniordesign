// On my UNO, I'm using these
#define MSHCLK 5
#define MSHENA 6
#define MSHDTA 7

// On Goldhat they're as follows
//#define MSHCLK 38
//#define MSHENA 18
//#define MSHDTA 19

#define MA_ENA 10
#define MB_ENA 12
#define MC_ENA 9
#define MD_ENA 13

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

  // Serial enable is active low
  // Hold it low while we shift in data
  payload = 1;
  for(int i = 0; i < 8; i++){
    digitalWrite(MSHENA, LOW);
    shiftOut(MSHDTA, MSHCLK, LSBFIRST, payload);
    digitalWrite(MSHENA, HIGH);
    delay(500);
    payload <<= 1;
  }

  // tTggle the bits in payload for maximum blink
  payload ^= 0xFF;

  delay(200);

  for(int i = 0; i < 256; i++)
  {
    analogWrite(MA_ENA, i);
    delay(5);
  }
  for(int i = 0; i < 256; i++)
  {
    analogWrite(MA_ENA, 255-i);
    delay(1);
  }
  
  delay(200);
  
  for(int i = 0; i < 256; i++)
  {
    analogWrite(MB_ENA, i);
    delay(5);
  }
  for(int i = 0; i < 256; i++)
  {
    analogWrite(MB_ENA, 255-i);
    delay(1);
  }

  delay(200);

  // Wait
  delay(1000);

}
