import themidibus.*;
float cc[] = new float[256];
MidiBus myBus;

PFont myFont;

String txt;
float y = 0;


void setup(){
 fullScreen(P3D);
  hint(DISABLE_DEPTH_TEST);
  String[] lines = loadStrings("statement.txt");
  txt = join(lines, "\n");
  y = height;
  myFont = createFont("Impact",160);
    background(0);
    MidiBus.list();  // Shows controllers in the console
  myBus = new MidiBus(this, "SLIDER/KNOB","CTRL");  // input and output
  
  for (int i = 16; i < 24; i++) {  // Sets only the knobs (16-23) to be max @ start
    cc[i] = 127;
  }
  cc[17] = 1;
}

void draw(){
  float fillOpacity =  map(cc[16], 0, 127,33, 1);
 fill(0,fillOpacity);
 rect(0,0,width,height);
  translate(width/2,height/2);
  fill(255);
  textFont(myFont);
  textSize(150);
  textAlign(CENTER);
  float rX =  map(cc[17], 0, 127,PI/4, TWO_PI);
  float rY =  map(cc[18], 0, 127,PI/4, TWO_PI);
  float rZ =  map(cc[19], 0, 127,PI/4, TWO_PI);
   float yS = map(cc[20], 0,127, .1, 5);
  rotateX(rX);
  rotateY(rY);
  rotateZ(rZ);
  text(txt,-width/2 *.7,y,width * 0.8,height*1000);
  y= y -yS;
  if (cc[45] == 127) { // Press #45 to save an image
    saveImage();       // See save function
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
