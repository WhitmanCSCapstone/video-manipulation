/*
  Timing_demo: This sketch demonstrates simple timing techniques using frameCount and text displays. 
  Keys can be pressed to show another dialog.
*/

boolean blinker;
int timer = -3000;
 
void setup() {
  size(700,400);
  textFont(createFont("Arial",30));
}
 
void draw() {
  background(255);
  fill(0);
  text("you are in frame: " + frameCount,50,50);
  text(millis()/1000 + " seconds have passed since the start", 50,100);
  text("this text will be here forever",50,150);
  if (frameCount < 500) {
    text("this text will be here for 500 frames",50,200);
  }
  if (frameCount > 800) {
    text("this text will be here from 800 frames onwards",50,200);
  }
  if (millis() < 8000) {
    text("this text will be here the first 8 seconds",50,250);
  }
  if (millis() > 12000) {
    text("this text will be here from 12 seconds onwards",50,250);
  }
  if (frameCount % 12 == 0) { blinker = !blinker; }
  if (blinker) {
    text("this text will blink",50,300);
  }
  if (millis() - timer < 3000) {
    text("this text will be here 3 secs after pressing a key",50,350);
  }
}
 
void keyPressed() {
  timer = millis();
}
