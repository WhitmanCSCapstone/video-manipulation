import themidibus.*;
float cc[] = new float[256];
MidiBus myBus;

import processing.video.*;

Movie video1;


float video1x = width;
float video1y = height;
int n = 0;


void setup() {
  fullScreen(P2D);
  noCursor();
 MidiBus.list();  // Shows controllers in the console
  myBus = new MidiBus(this, "SLIDER/KNOB","CTRL");  // input and output
  
  for (int i = 16; i < 24; i++) {  // Sets only the knobs (16-23) to be max @ start
    cc[i] = 127;
  }
  // Load and loop Video 1
  video1 = new Movie(this, "g.mov");
  video1.loop();
 
}

void draw() {
  
  background(0, 0, 0);
   imageMode(CENTER);
  if (video1.available() == true) {
    video1.read(); 
  }
 
  
  image(video1, width/2,height/2,width, height);
  int m = int(map(cc[16],0,127,1,127));
  if(n % m == 0){
  float index = random(0, video1.duration());
    video1.jump(index); 
  }
  
  textSize(80);
  fill(255,10,15);
 text("random at  " + m + "  milliseconds" ,90,150);
   n = n + 1;
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
