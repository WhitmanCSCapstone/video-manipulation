//import processing.video.*;

//Movie vid;
import themidibus.*;
float cc[] = new float[256];
MidiBus myBus;
float ry = 0.0;
float rx =0.0;

void setup(){
  //size(936,288,P3D);
  fullScreen(P3D);
  MidiBus.list();  // Shows controllers in the console
  myBus = new MidiBus(this, "SLIDER/KNOB","CTRL");  // input and output
  
  for (int i = 16; i < 24; i++) {  // Sets only the knobs (16-23) to be max @ start
    cc[i] = 127;
  }
  //vid = new Movie(this, "uuu.mov");
  //vid.loop();
  //noStroke()

 fill(0);

}

void draw(){
  noStroke();
  float bop = map(cc[21],0,127,255,5);
  fill(0,bop);
  rect(0,0,0,width,height);
   stroke(255);
  float w = map(cc[19],0,127,10,2);
   strokeWeight(w);
  translate(width / 2, height/2);
   float ma = map(cc[16], 0,127,0,65);
   float mb = map(cc[17], 0,127,0,65);
   rotateY (ry);
  ry = ry + ma;
  rotateX (rx);
rx = rx + mb;//}
   beginShape();
  // tint(255,120);
  //texture(vid);
  float cw = map(cc[18],0,127,-height/2,height/2);
  float co = map(cc[20],0,127,255,5);
    float s = map(cc[22],0,127,.2,2);
  fill(0,co);
  ellipse(cw,0,height *s,height *s);
  vertex(-width/2, - height/2, 0, 0, 0);
  vertex(width/2, -height/2, 0, width, 0);
  vertex(width/2, height/2, 0, width, height);
  vertex(-width/2, height/2, 0, 0, height);
  endShape();

//saveFrame("#######.tiff");
    
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
