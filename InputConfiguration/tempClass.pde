/*
  keeptryingrotatingslats: First four midi knobs control the speed of rotating slats.
  They correspond top to bottom, first to last knob.
*/
import themidibus.*;
float cc[] = new float[256];
MidiBus myBus;

import processing.video.*;
float rx1 = 0.0;
float rx2 = 0.0;
float rx3 = 0.0;
float rx4 = 0.0;
float rx5 = 0.0;

Movie cam;

void setup() {
  //size(1280, 800, P2D);
  fullScreen(P3D);
  MidiBus.list();  // Shows controllers in the console
  myBus = new MidiBus(this, "nanoKONTROL2","CTRL");  // input and output
  
  for (int i = 16; i < 24; i++) {  // Sets only the knobs (16-23) to be max @ start
    cc[i] = 127/2;
  }
  cam = new Movie(this,"xxx.mov");
  cam.loop();
  noStroke();
}
void draw() {
  if (cam.available() == true) {
    cam.read();
  }
  pushMatrix();
  translate(0,height *.1,0);
  float ma = map(cc[16], 0,127,.0,.1);
  rotateX (rx1);
  rx1 = rx1 + ma;
  beginShape();
  texture(cam);
  vertex(0, 0, 0, 0);
  vertex(width, 0, cam.width,0);
  vertex(width, height*.2, cam.width, cam.height*.2);
  vertex(0, height *.2, 0, cam.height* .2);
  endShape();
  popMatrix();
  
//   pushMatrix();
//   translate(0,height *.3,0);
//   float na = map(cc[17], 0,127,.0,.1);
//   rotateX (rx2);
//   rx2 = rx2 + na;
//   beginShape();
//   texture(cam);
//   vertex(0, height*.2, 0, cam.height *.2);
//   vertex(width, height *.2,cam.width, cam.height * .2);
//   vertex(width, height * .4, cam.width, cam.height *.4);
//   vertex(0, height * .4, 0, cam.height *.4);
//   endShape();
//   popMatrix();
  
//   pushMatrix();
//   translate(0,height *.5,0);
//   float oa = map(cc[18], 0,127,.0,.1);
//   rotateX (rx3);
//   rx3 = rx3 + oa;
//   beginShape();
//   texture(cam);
//   vertex(0, height * .4,0, cam.height *.4);
//   vertex(width, height * .4, cam.width, cam.height *.4);
//   vertex(width, height *.6, cam.width, cam.height *.6);
//   vertex(0, height *.6, 0,cam.height *.6);
//   endShape();
//   popMatrix();
  
//   pushMatrix();
//   translate(0,height *.7,0);
//   float pa = map(cc[19], 0,127,.0,.1);
//   rotateX (rx4);
//   rx4 =rx4 +pa;
//   beginShape();
//   texture(cam);
//   vertex(0, height *.6, 0, cam.height * .6);
//   vertex(width, height * .6, cam.width, cam.height * .6);
//   vertex(width, height * .8, cam.width, cam.height * .8);
//   vertex(0, height * .8, 0, cam.height * .8);
//   endShape();
//   popMatrix();
  
//   pushMatrix();
//   translate(0,height *.9,0);
//   float qa = map(cc[20], 0,127,.0,.1);
//   rotateX (rx5);
//   rx5 =rx5 +qa;
//   beginShape();
//   texture(cam);
//   vertex(0, height *.8, 0, cam.height * .8);
//   vertex(width, height * .8, cam.width, cam.height * .8);
//   vertex(width, height , cam.width, cam.height );
//   vertex(0, height, 0, cam.height );
//   endShape();
//   popMatrix();
  
  // Preview the whole image
  //image(cam, 0, 0, cam.width/8, cam.height/8);
}

void controllerChange(int channel, int number, int value) {
  // Receive a controllerChange
  println();
  println("Controller Change:");
  println("--------");
  println("Channel:"+channel);
  println("Number:"+number);
  println("Value:"+value);
  println("Frame rate:"+frameRate);
  cc[number] = value;  // saves the midi output # to be converted later for what we need
}
