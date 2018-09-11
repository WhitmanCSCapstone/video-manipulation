//import processing.video.*;

//PImage img;

//Capture cam;
import processing.sound.*;
float amplitude = 0.00001;
float frequency = 200.0;
AudioIn mic;
Amplitude amp;

import themidibus.*;
float cc[] = new float[256];
MidiBus myBus;

void setup() {
  size(700,700);
  //cam = new Capture(this, width, height, 30);
//cam.start();
  mic = new AudioIn(this, 0);
  mic.start();
  amp = new Amplitude(this);
  amp.input(mic);
  MidiBus.list();  // Shows controllers in the console
  myBus = new MidiBus(this, "SLIDER/KNOB","CTRL");  // input and output
  
  for (int i = 16; i < 24; i++) {  // Sets only the knobs (16-23) to be max @ start
    cc[i] = 127;
  }
}

void draw() {
  //cam.read();
  background(255);
  //image(cam,0,0);
  
  float curveWidth = map(cc[16],0,127, 2.0, 255.0);
  float curveThickness = map(cc[17],0,127,1.0, 255.0);
  float angleOffset = map(cc[18],0,1270,1.0, 5.0);
  
  float angleIncrement = map(amp.analyze(), 0.001, 0.06, 0.0, 0.2);
  float angleA = 0.0;
  float angleB = angleA + angleOffset;
  
  float k =  map(cc[19],0,127, .5, 20.0);
  
  for (int i = 0; i < height; i += curveWidth*k) {
    float waveColor = map(amp.analyze(), 0.001, 0.2, 0, 255);
 
 
    noStroke();

    pushMatrix();
    translate(0, 400);
    //fill(waveColor);
    fill(0);
    beginShape(QUAD_STRIP);
    for (int x = 0; x <= width; x += 10) {
      //float y1 = i + (sin(angleA)* curveWidth);
      //float y2 = i + (sin(angleB)* curveWidth);
      float y1 = i + (sin(angleB) * curveWidth);
      float y2 = i + (cos(angleA) * curveWidth);
      vertex(x, y1);
      vertex(x, y2 + curveThickness);
      angleA += angleIncrement;
      angleB = angleA + angleOffset;
    }
    endShape();
    
    pushMatrix();
    scale(1.0, -1.0);
    beginShape(QUAD_STRIP);
    for (int x = 0; x <= width; x += 10) {
      float y1 = i + (sin(angleA)* curveWidth);
      float y2 = i + (sin(angleB)* curveWidth);
      //float y1 = i + (sin(angleB) * curveWidth);
      //float y2 = i + (cos(angleA) * curveWidth);
      vertex(x, y1);
      vertex(x, y2 + curveThickness);
      angleA += angleIncrement;
      angleB = angleA + angleOffset;
    }
    endShape();
    popMatrix();
    popMatrix();
  }
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
