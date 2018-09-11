PShader shader;
PImage img;
import themidibus.*;
float cc[] = new float[256];
MidiBus myBus;
import processing.video.*;
Movie vid;
import processing.sound.*;
float inc = 0;
float amplitude = 0.05;
float frequency = 20.0;


AudioIn mic;
Amplitude amp;


void setup(){
  size(1280,800, P2D);
  MidiBus.list();  // Shows controllers in the console
  myBus = new MidiBus(this, "SLIDER/KNOB","CTRL");  // input and output
  
  for (int i = 16; i < 24; i++) {  // Sets only the knobs (16-23) to be max @ start
    cc[i] = 127;
  }
  vid = new Movie(this, "xxx.mov");
 vid.loop();
  
   mic = new AudioIn(this,0);
mic.start();
amp = new Amplitude(this);
amp.input(mic);
  shader = loadShader("sine.glsl");
  img = loadImage("img.jpg");
  
  noStroke();
}
void movieEvent(Movie m) {

 vid.read();
 
}

void draw(){
    shader.set("amplitude", amplitude);
  shader.set("frequency", frequency);
  
  vid.read();
  vid.speed(map(cc[16],0,127,.5,1.5));
  shader.set("srcTex", vid);
  shader.set("time", inc);
 
  inc +=  map(cc[17],0,127,0.001,.5);
  amplitude = map(cc[18],0,127,0,.09);
  frequency = map(cc[19],1,127,10,90);
  shader(shader);
  rect(0,0,width, height);
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

  //if (cc[42] == 127) { // Press #42 to pause
   //pauseToggle = !pauseToggle;
  }

// }
