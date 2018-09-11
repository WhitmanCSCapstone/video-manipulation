

import themidibus.*;
float cc[] = new float[256];
MidiBus myBus;
import processing.video.*;

Movie movie;



float a;
float rx = 0.0; 
void setup() {
 // size(400, 400, P2D);
 fullScreen(P3D);
 MidiBus.list();  // Shows controllers in the console
  myBus = new MidiBus(this, "SLIDER/KNOB","CTRL");  // input and output
  
  for (int i = 16; i < 24; i++) {  // Sets only the knobs (16-23) to be max @ start
    cc[i] = 127;
  }
  movie = new Movie(this, "ppp.mov");
  movie.loop(); 
 
}


 


void draw() {
  if (movie.available() == true) {
   movie.read(); 
  }
  camera(width/2, height/2, (height/2) / tan(PI/map(cc[0],0, 127,7, 3)), width/2, height/2, 0, 0, 1, 0);
  background(0);
int m = round(map(cc[19],0,127,5,50)); 
  drawMesh(m,m,a);
 

float flow = map(cc[16],0,127,.01,.09);
  a += flow;

}

ArrayList<PVector[]> drawStrip(int x, int y, float a) {
  ArrayList<PVector[]> stripList = new ArrayList<PVector[]>();
  for (int j = 0; j < x+1; j++) {
    PVector[] strip = new PVector[x+1];
    for (int i = 0; i < y+1; i++) {
      float pm = map(cc[17],0,127,1,27);
      float param = pm *(i+j)/(x+1+y+1);
      //Moving vectors
      float mod = map(cc[18],0,127,-5,5);
      strip[i] = new PVector(width/y * i + (15 + mod) *cos(a+param), height/(y-1) * j+ (15 + mod) *sin(a+param), 0);
      //Static vectors
      //strip[i] = new PVector(width/y * i, height/(y-1) * j, 0);
    }
    stripList.add(strip);
  }
  return stripList;
}

void drawMesh(int x, int y, float a) {
  
  noStroke();
  ArrayList<PVector[]> strips = drawStrip(x, y, a);
  for (int i = 0; i < strips.size()-2; i++) {
    float v1 = 1.0*i/(strips.size()-2);
    float v2 = 1.0*(i+1)/(strips.size()-2);

    PVector[] list1=strips.get(i);    
    PVector[] list2=strips.get((i+1));

    beginShape(QUAD_STRIP);
    float op = map(cc[20],0,127,0,255);
    tint(255,op);
texture(movie); // or image in your case!
textureMode(NORMAL);
    for (int j = 0; j < list1.length; j++) {

      float u = 1.0*j/(list1.length-1);
      PVector vec1 = list1[j];
      PVector vec2 = list2[j];

      vertex(vec1.x, vec1.y, u, v1);
      vertex(vec2.x, vec2.y, u, v2);
    }

    endShape();
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
