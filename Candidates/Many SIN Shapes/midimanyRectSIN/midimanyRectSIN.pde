import themidibus.*;
float cc[] = new float[256];
MidiBus myBus;

float angle = 0.0;
  float offset = 0.0;
float w = 24;
void setup(){
  size(1280,800);
  MidiBus.list();  // Shows controllers in the console
  myBus = new MidiBus(this, "SLIDER/KNOB","CTRL");  // input and output
  
  for (int i = 16; i < 24; i++) {  // Sets only the knobs (16-23) to be max @ start
    cc[i] = 127;
  }
   background (255);
   rectMode(CENTER);
   //noStroke();
}

void draw(){
 float op = map(cc[19],0,127,20,255);
  translate(width/2,height/2);
  rectMode(CENTER);
  fill(255,op);
rect(0,0,width,height);
  
  w = map(cc[18],0,127,.1, 800);
  for(float x = 0; x < width; x +=w){
    float a = angle + offset;
  float h = map(sin(a),-1,1,0,700);
  fill(255);
  float sW = map(cc[20],0,127,.2,1.2);
  strokeWeight(sW);
  rect(x- width/2 + w/2,0,w, h);
  offset += map(cc[17],0,127,.009,9);
  }
  angle += map(cc[16],0,127,.009,9);
 

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
