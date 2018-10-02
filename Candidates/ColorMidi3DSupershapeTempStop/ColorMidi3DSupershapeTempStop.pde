/*
  ColorMidi3DSupershapeTempStop: Generates a 3D image using midi controller. 
  This is accomplished by mapping a whole bunch of values to the arrays. 
  Visualization is done with peasycam. 
  There is a lot of room for optimizing and fine tuning.
  Ask Justin where he got this code. It would be cool for sliders to control camera.
*/
import themidibus.*;
float cc[] = new float[256];
MidiBus myBus;

// import peasy.*;
// PeasyCam cam;

PVector [][] globe;
int total = 200;
float m = 0.0;
float mchange = 0.0;
float sm = 0.0;
float l = 0.0;
float offset = 0;
float xoffset = 400;
float yoffset = 400;
void setup(){
  size(1280,800,P3D);
  MidiBus.list();  // Shows controllers in the console
  myBus = new MidiBus(this, "nanoKONTROL2","CTRL");  // input and output g:-- Changed from SLIDER/KNOB for windows
  
  for (int i = 16; i < 24; i++) {  // Sets only the knobs (16-23) to be reasonable @ start - will still jump
    cc[i] = 20;
  }
  // cam = new PeasyCam(this,1000); //room for optimizing camera location
  colorMode(HSB);
  globe = new PVector[total+ 1][total+ 1];
  noStroke();
}

float a = 1;
float b = 1;

float supershape(float theta, float m, float n1, float n2, float n3){
  float t1 = abs((1/a) * cos( m * theta /4));
  t1 = pow(t1,n2);
  float t2 = abs((1/b)*sin(m * theta/4));
  t2 = pow(t2,n3);
  float t3 = t1 + t2;
  float r = pow(t3, -1/ n1);
  return r;
}

void draw(){
  //g: for all sketches, save cc to variables for clarity before doing stuff on them
  
  //Identify variables:
  float polycount = cc[16];
  float vibrations = cc[17];
  float period = cc[18];
  float timestep = cc[19];
  
  l = map(timestep,0,127,1,127);
  m = map(sin(mchange),-1,1,0,l);
  sm = map(period,0,127,0.0, 0.009);
  
  //timestep
  mchange += sm;
  background(0);
  noStroke();
  //Generates shadows underfolds of polygons
  lights();
  
  float r = 200;
  total = round(map(polycount,0,127,2,128));

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
        int u = round(map(vibrations,0,127,0,127));
        v.mult(u);
        globe[i][j].add(v);
       }
    }
    offset+=5;
    //Swapping where i and j are used to calculate hu switches stripes
    //adding offset makes them flow in a cool way
  for(int i = 0; i< total; i++){
    beginShape(TRIANGLE_STRIP);
    float hu = map(i,0,total,0,255* 6);
    fill((hu+offset) % 255,255,255);
    for(int j = 0; j < total+ 1; j++){
      PVector v1 = globe[i][j];
      vertex(v1.x+xoffset,v1.y+yoffset,v1.z);
      PVector v2 = globe[i+1][j];
      vertex(v2.x+xoffset,v2.y+yoffset,v2.z);
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
  cc[number] = value;  // saves the midi output # to be converted later for what we need
}
