import themidibus.*;
float cc[] = new float[256];
MidiBus myBus;
Supershape s = new Supershape(900,900);
Supershape b = new Supershape(400,400);

void setup() 
{
  size(1920,1080,P3D);
  MidiBus.list();  // Shows controllers in the console
  myBus = new MidiBus(this, "nanoKONTROL2","CTRL");  // input and output g:-- Changed from SLIDER/KNOB for windows
  
  for (int i = 16; i < 24; i++) {  // Sets only the knobs (16-23) to be reasonable @ start - will still jump
    cc[i] = 20;
  }
  // cam = new PeasyCam(this,1000); //room for optimizing camera location
  colorMode(HSB);
  noStroke();
}

void draw() { 
  background(204);
  s.update(); 
  b.update();  
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
