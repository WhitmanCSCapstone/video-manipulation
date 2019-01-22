import themidibus.*;
float cc[] = new float[256];
MidiBus myBus;

import processing.video.*;
Movie cap;
int capW, capH;
float step;
PVector[][]points;
float angle;
PShape canvas;

void setup(){
  size(1280,800,P3D);
  hint(DISABLE_DEPTH_TEST);
  MidiBus.list();  // Shows controllers in the console
  myBus = new MidiBus(this, "SLIDER/KNOB","CTRL");  // input and output
  
  for (int i = 16; i < 24; i++) {  // Sets only the knobs (16-23) to be max @ start
    cc[i] = 127;
  }
  capW = 640;
  capH = 480;
  step = 10;
  cap = new Movie(this,"faces.mov");
  cap.loop();
  initGrid();
  initShape();
  shapeMode(CENTER);
  angle = 0;
 
  noCursor();
}
void movieEvent(Movie cap) {
  cap.read();
}

void initGrid(){
   cap.read();

  points = new PVector[floor(cap.height/step)+1][floor(cap.width/step)+1];
  for(int y = 0;y<points.length;y++){
for(int x = 0;x<points[y].length;x++){
  float xVal = constrain(x*step,0,cap.width-1);
  float yVal = constrain(y*step,0,cap.height-1);
  points[y][x] = new PVector(xVal,yVal,0);
}
  }
}

void initShape(){
  canvas = createShape(GROUP);
  for(int y = 0;y<points.length-1;y++){
    PShape tmp = createShape();
    tmp.beginShape(QUAD_STRIP);
    tmp.noStroke();
    //tmp.strokeWeight(2);
    for(int x = 0;x<points[y].length;x++){
      PVector p1 = points[y][x];
      PVector p2 = points[y+1][x];
  
  tmp.vertex(p1.x,p1.y,p1.z);
  tmp.vertex(p2.x,p2.y,p2.z);
    }
    tmp.endShape();
    canvas.addChild(tmp);
  }
}

color getColor(int x, int y){
  
  int x1 = constrain(floor(x*step), 0,cap.width-1);
  int y1 = constrain(floor(y*step), 0,cap.height-1);
  return cap.get(x1,y1);
}

void updatePoints(){
  float factorRange = map(cc[18],0,127,.01,.9);
  float factor = factorRange;
  for(int y =0; y<points.length;y++){
    for(int x =0; x<points[y].length;x++){
      color c = getColor(x,y);
      points[y][x].z = brightness(c)*factor;
    }
  }
}
void updateShape(){
  for(int i =0;i<canvas.getChildCount();i++){
for(int j =0;j<canvas.getChild(i).getVertexCount();j++){
  PVector p = canvas.getChild(i).getVertex(j);
  int x = constrain(floor(p.x/step),0,points[0].length-1);
  int y = constrain(floor(p.y/step),0,points.length-1);
  p.z = points[y][x].z;
  color c =getColor(x,y);
  canvas.getChild(i).setFill(j,c);
  canvas.getChild(i).setVertex(j,p);
}
  }
}

void draw(){
 
 cap.speed(map(cc[0],0,127,.5,2));
  updatePoints();
  updateShape();
  float opacity = map(cc[20],0,127,2,255);
  fill(0, opacity);
 rect(0,0,width,height);
  float closer = map(cc[16],0,127,-500,400);
  float mh = map(cc[1],0,127,height -300,300);
  translate(width/2,mh,closer);
  //if(mousePressed){
  rotateX(radians(angle));
  //}
  shape(canvas,0,0);
  float angleSpeed = map(cc[17],0,127,0,1);
  angle += angleSpeed;
  angle %= 360;
  float newStep = map(cc[19],0,127,20,9);
  step = newStep;
  //float ms = map(cc[20],0,127,1,20);
  //strokeWeight(ms);
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
