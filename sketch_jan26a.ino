
#define ENABLE 5
#define DIRA 3
#define DIRB 4

int i;
int buttonState = A2; //potentiometer setup
int latch=9;  //74HC595  pin 9 STCP
int clock=10; //74HC595  pin 10 SHCP
int data=8;   //74HC595  pin 8 DS
unsigned char table[]=
{0x3f,0x06,0x5b,0x4f,0x66,0x6d,0x7d,0x07,0x7f,0x6f,0x77,0x7c
,0x39,0x5e,0x79,0x71,0x00};


void setup() {
  // put your setup code here, to run once:
  pinMode(ENABLE,OUTPUT); //fan
  pinMode(DIRA,OUTPUT);
  pinMode(DIRB,OUTPUT);
  pinMode(A2, INPUT); //potentiometer
  pinMode(latch,OUTPUT);  //4 digits
  pinMode(clock,OUTPUT);
  pinMode(data,OUTPUT);
  pinMode(12, OUTPUT);
  pinMode(11, OUTPUT);
  pinMode(7, OUTPUT);
  pinMode(6, OUTPUT);
  Serial.begin(9600);
}

int firstdigit(int a){
  return (a%10);
  }
int seconddigit(int a){
  return (a%100)/10;
}
int thirddigit(int a){
  return (a%1000)/100;
}
int forthdigit(int a){
  return a/1000;
}

int c = 0;

void Display(unsigned char num, unsigned int digitnumber)
{

  digitalWrite(latch,LOW);
  shiftOut(data,clock,MSBFIRST,table[num]);
  digitalWrite(latch,HIGH);
  if (digitnumber == 1){
  digitalWrite(12, LOW);
  digitalWrite(11, HIGH);
  digitalWrite(7, HIGH);
  digitalWrite(6, HIGH);
  }
  else if (digitnumber == 2){
  digitalWrite(12, HIGH);
  digitalWrite(11, LOW);
  digitalWrite(7, HIGH);
  digitalWrite(6, HIGH);
  }
  else if (digitnumber == 3){
  digitalWrite(12, HIGH);
  digitalWrite(11, HIGH);
  digitalWrite(7, LOW);
  digitalWrite(6, HIGH);
  }
  else if (digitnumber == 4){
  digitalWrite(12, HIGH);
  digitalWrite(11, HIGH);
  digitalWrite(7, HIGH);
  digitalWrite(6, LOW);
  }
}

int a = 0;

void loop() {
  // put your main code here, to run repeatedly:
  c = c + 1;
  if (c%100 == 0){
  a = analogRead(buttonState);}
  Serial.println(a);
  int b = a/4;
 
  analogWrite(ENABLE,b); //enable on
  digitalWrite(DIRA,HIGH); //one way
  digitalWrite(DIRB,LOW);
  Display(firstdigit(a), 1);
  delay(2);
  Display(seconddigit(a), 2);
  delay(2);
  Display(thirddigit(a), 3);
  delay(2);
  Display(forthdigit(a), 4);
  delay(2);
}
