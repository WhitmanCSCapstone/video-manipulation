import themidibus.*;
float cc[] = new float[256];
MidiBus myBus;
import peasy.*;

PeasyCam cam;

PVector [][] globe;
  int total = 200;
  float m = 0.0;
  float mchange = 0.0;
  float sm = 0.0;
  //total = 5; blocky
void setup(){
  size(1280,800,P3D);
   MidiBus.list();  // Shows controllers in the console
  myBus = new MidiBus(this, "SLIDER/KNOB","CTRL");  // input and output
  
  for (int i = 16; i < 24; i++) {  // Sets only the knobs (16-23) to be max @ start
    cc[i] = 127;
  }
  cam = new PeasyCam(this,300);
  colorMode(HSB);
  globe = new PVector[total+ 1][total+ 1];
  noStroke();
}

float a = 1;
float b = 1;

float supershape(float theta, float m, float n1, float n2, float n3){
  //float r = 1;
  
  
  float t1 = abs((1/a) * cos( m * theta /4));
  t1 = pow(t1,n2);
  float t2 = abs((1/b)*sin(m * theta/4));
  t2 = pow(t2,n3);
  float t3 = t1 + t2;
  float r = pow(t3, -1/ n1);
  return r;
}
void draw(){
  m = map(sin(mchange),-1,1,0,127);
  sm = map(cc[18],0,127,0.0, 0.009);
  mchange += sm;
  background(0);
  //fill(255);
  lights();
  float r = 200;
  total = round(map(cc[16],0,127,2,127));
    for(int i = 0; i< total+1; i++){
    float lat = map( i,0, total,- HALF_PI,HALF_PI);
     float r2 = supershape(lat, m,10.0,10.0,10.0);
    for(int j = 0; j< total + 1; j++){
    float lon = map( j,0, total, - PI, PI);
    float r1 = supershape(lon,m,60.0,100.0,30.0);
    float x = r * r1 * cos(lon) * r2 * cos(lat);
    float y = r * r1 *sin(lon) * r1 * r2 * cos(lat);
    float z = r * r2 * sin(lat);
        globe[i][j] = new PVector(x,y,z);
        PVector v = PVector.random3D();
        int u = round(map(cc[17],0,127,0,127));
        
        v.mult(u);
        globe[i][j].add(v);
    }
    }
  for(int i = 0; i< total; i++){
 
   
     
    beginShape(TRIANGLE_STRIP);
    for(int j = 0; j< total+ 1; j++){
      //float hu = map(j,0,total,0,255* 6);
     // fill(hu % 255,255,255);
      noStroke();
      stroke(255);
      fill(255);
      //noFill();
  PVector v1 = globe[i][j];
       // strokeWeight(2);
       //stroke(255);
        vertex(v1.x,v1.y,v1.z);
        PVector v2 = globe[i+1][j];
        vertex(v2.x,v2.y,v2.z);
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
