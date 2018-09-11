import themidibus.*;
float cc[] = new float[256];
MidiBus myBus;

import processing.video.*;

Movie vid;

import processing.sound.*;
float amplitude = 0.01;
float frequency = 20.0;
AudioIn mic;
Amplitude amp;

void setup() {
  //size(1280, 800, P2D);
  fullScreen(P2D);
   MidiBus.list();  // Shows controllers in the console
  myBus = new MidiBus(this, "SLIDER/KNOB","CTRL");  // input and output
  
  for (int i = 16; i < 24; i++) {  // Sets only the knobs (16-23) to be max @ start
    cc[i] = 127;
  }

  vid = new Movie(this, "mmm.mov");
  vid.loop();
  mic = new AudioIn(this, 0);
  mic.start();
  amp = new Amplitude(this);
  amp.input(mic);
}
void draw() {
  if (vid.available() == true) {
    vid.read();
  }

  //float divide = map(mouseX, 0, width, 0, width);
  //image(cam, 0, 0, width/2, height);
  //noStroke();

  float xx = mouseX;

  // Left texture
  beginShape();
  tint(255,map(cc[19],0,127,255,20));
  texture(vid);
  vid.speed(map(cc[18],0,127,.5,5));
  // text(x, y, tx, ty);
  vertex(0, 0, 1  ,  map(amp.analyze(), 0,0.05, 0,800));
  vertex(width, 0, vid.width* map(cc[17], 0,127, 1,.005), map(amp.analyze(), 0,0.05,0,800));
  vertex(width, height, vid.width * map(cc[17], 0,127, 1,.005), vid.height);
  vertex(0, height, 1 , vid.height);
  endShape();

  // Right texture, inverted over Y-axis
  //beginShape();
  //texture(vid);
  // text(x, y, tx, ty);
  //vertex(xx, 0, vid.width/2, 0);
  //vertex(width, 0, 0, 0);
  //vertex(width, height, 0, vid.height);
  //vertex(xx, height, vid.width/2, vid.height);
  //endShape();

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
  //println("Font:"+fontNames[fontSelect]);   // How can I get it to say the font name, not just the #?
 // println("Font number:"+fontSelect);
  cc[number] = value;  // saves the midi output # to be converted later for what we need

 // if (cc[42] == 127) { // Press #42 to pause
  // pauseToggle = !pauseToggle;

  }
 //}
