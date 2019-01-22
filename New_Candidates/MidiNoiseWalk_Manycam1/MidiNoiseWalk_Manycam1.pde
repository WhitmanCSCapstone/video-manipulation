// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

Walker[] w;
import processing.video.*;
import themidibus.*;
float cc[] = new float[256];
MidiBus myBus;
Capture cam;
int total = 0;

void setup() {
  //size(1280, 720);
  fullScreen();
  MidiBus.list();  // Shows controllers in the console
  myBus = new MidiBus(this, "SLIDER/KNOB","CTRL");  // input and output
  
  for (int i = 16; i < 24; i++) {  // Sets only the knobs (16-23) to be max @ start
    cc[i] = 127;
  }
  cam = new Capture(this,1280,800);
   cam.start();

  w = new Walker[1000];
  for (int i = 0; i < w.length; i++) {
    w[i] = new Walker();
  }
  
    background(0);
}
void captureEvent(Capture cam){
  cam.read();
}
void draw() {
//cam.read();
//image(cam,0,0,width,height);
  int o = int(map(cc[20],0,127,.001,10));
  noiseDetail(o,0.3);

  if (frameCount % 3 == 0) {
    total = total + 1;
    if (total > w.length-1) {
      total = w.length-1;
    }
  }

  for (int i = 0; i < total; i++) {
    w[i].walk();
    w[i].display();
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
