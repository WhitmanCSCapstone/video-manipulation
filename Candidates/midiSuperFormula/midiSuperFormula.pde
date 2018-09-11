import themidibus.*;
float cc[] = new float[256];
MidiBus myBus;
float t = 0.0;

void setup(){
 size(800,800); 
  noFill();
  //fill(0);
  stroke(0);
  strokeWeight(1);
   MidiBus.list();  // Shows controllers in the console
  myBus = new MidiBus(this, "SLIDER/KNOB","CTRL");  // input and output
  
  for (int i = 16; i < 24; i++) {  // Sets only the knobs (16-23) to be max @ start
    cc[i] = 127;
  }
}

float r(float theta, float a,float b, float m, float n1, float n2, float n3){
  
  return pow(pow(abs(cos(m * theta/ 4.0)/a), n2) + 
  pow(abs(sin(m * theta/ 4.0)/b), n3), -1.0/n1);
}

void draw(){
  background(255);
  translate(width/2, height/2);
  beginShape();
  //add vertices
  for (float theta = 0; theta <= 2 * PI; theta +=0.01){
   float rad = r(theta,
  // map(cc[16],0,127,1,20),
  sin(t) * 2,//a
   //2,
   map(cc[17],0,127,1,20), //b
  //2,
   map(cc[18],0,127,0,600), //m
   //6,
  map(cc[19],0,127,1,15), //n1
  //sin(t) * 4,
   //1,
  map(cc[20],0,127,1,5),//n2
  map(cc[21],0,127,1,5)//n3
    //sin(t)* .5 + .5,
   //cos(t)* .5 + .5
  );

   
   float x = rad * cos(theta) * 50;
   float y = rad * sin(theta) * 50;
   vertex(x,y);
  }
  
  endShape(CLOSE);
 float u = map(cc[20],0,127,.5,.01); //n3
  t += u;
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
