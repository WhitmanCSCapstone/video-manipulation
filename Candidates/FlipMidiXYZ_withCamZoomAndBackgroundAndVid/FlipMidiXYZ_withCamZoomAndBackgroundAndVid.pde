/*
  FlipMidiXYZ_withCamZoomAndBackgroundAndVid: Pommegranate.
  Uses Midi controller to rotate and modify an input video. 
*/

import themidibus.*;
float cc[] = new float[256];
MidiBus myBus;
Capture cam;
import processing.video.*;
Movie mov;
PGraphics vid;
import processing.sound.*;
float inc = 0;
float amplitude = 0.05;
float frequency = 20.0;
AudioIn mic;
Amplitude amp;
float rx = 0.0;
float ma = 0.0;
boolean stime = false;
boolean movtime = false;
boolean camTime = true;
/**
 * Texture Quad. 
 * 
 * Load an image and draw it onto a quad. The texture() function sets
 * the texture image. The vertex() function maps the image to the geometry.
 */

PImage img;

void setup() {
  size(1280, 720, P3D);
  MidiBus.list();  // Shows controllers in the console
  myBus = new MidiBus(this, "nanoKONTROL2","CTRL");  // input and output
  // g: nanoKONTROL2 is something I added here. Previously it said SLIDER/KNOB. Possible need for WINdows compatibility and checking OS at launch.
  
  for (int i = 16; i < 24; i++) {  // Sets only the knobs (16-23) to be max @ start
    cc[i] = 127/2;
  }
  cam = new Capture(this, 1280,720);
  cam.start();
  mov = new Movie(this, "GG45.mov");
  mov.loop();
  vid = createGraphics(800,800);
  
  mic = new AudioIn(this,0);
  mic.start();
  amp = new Amplitude(this);
  amp.input(mic);
  img = loadImage("background.png"); 
  noStroke();
  background(0);
  set1();
}

void draw() {
    if (cam.available() && camTime) {
      //print("readingcam");
        cam.read();
    }
    if(movtime)
    mov.read();
  

  float fillOpacity =  map(cc[20], 0, 127,0, 255);
  tint(255,fillOpacity);
  translate(width / 2, height/2);
  //rotateX(map(amp.analyze(), 0.001, 0.2, -PI/2 +20, PI/2-20));
  //rotateZ(PI/8);

  ma = map(cc[17], 0,127,-.2,.2);
  rotateX (rx);
  rx = rx + ma;
  float rY = map(cc[18], 0,127,radians(0),radians(360));
  rotateY(rY);
  float rZ = map(cc[19], 0,127,radians(0),radians(360));
  rotateZ(rZ);
  beginShape();
  if (stime)
  {
    vid.beginDraw();
    update(vid);
    vid.endDraw();  
    texture(vid);
  }
  if(camTime)
  {
    print("camtime");
   //vid.beginDraw();
   //ucam(vid);
   //vid.endDraw();
   texture(cam);
  }
  if(movtime)
  {
    print("movtime");
   //vid.beginDraw();
   //ucam(vid);
   //vid.endDraw();
   texture(mov);
  }
  
  
  vertex(-600, -400, 0, 0, 0);
  vertex(600, -400, 0, vid.width, 0);
  vertex(600, 400, 0, vid.width, vid.height);
  vertex(-600, 400, 0, 0, vid.height);
  endShape();
  camera(width/2, height/2, (height/2) / tan(PI/map(cc[0],0,127,8, 4)), width/2, height/2, 0, 0, 1, 0);
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
  if (value == 127){
  if (number == 60){
     camTime = true;
     stime=false;
     movtime=false;
  }
  if(number == 61){
      stime = true;
      camTime=false;
      movtime=false;
  }
  if(number == 62){
   movtime = true;
   stime = false;
   camTime=false;
  }
  }
 // if (cc[42] == 127) { // Press #42 to pause
  // pauseToggle = !pauseToggle;
  }