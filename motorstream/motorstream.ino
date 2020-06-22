// On my UNO, I'm using these
#define MSHCLK 4
#define MSHENA 6
#define MSHDTA 7

// On Goldhat they're as follows
//#define MSHCLK 38
//#define MSHENA 18
//#define MSHDTA 19

#define MA_ENA 10
#define MB_ENA 11
#define MC_ENA 12
#define MD_ENA 13

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
  digitalWrite(MSHENA, LOW);
  shiftOut(MSHDTA, MSHCLK, LSBFIRST, payload);
  digitalWrite(MSHENA, HIGH);

  // tTggle the bits in payload for maximum blink
  payload ^= 0xFF;

  // Wait
  delay(1000);

}
