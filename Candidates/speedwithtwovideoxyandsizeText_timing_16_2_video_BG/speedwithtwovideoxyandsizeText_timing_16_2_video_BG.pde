  // Turn all knobs to max value before starting.
// Knob #17 (2nd from left) should start turned all the way to the left.
    // This knob controls speed and to avoid jarring speed changes, it starts out slow.
// Knobs #21 and #22 should start in the middle (pointing up)
    // This makes text movement more natural based on centered starting coordinates

// Global

import processing.video.*;
Movie movie1;
Movie movie2;

import themidibus.*;
float cc[] = new float[256];
MidiBus myBus;



float imageSize;
float s1;
float s2;

boolean pauseToggle = true;


void setup() {
  fullScreen();
  //size(500,500);
 
  background(255);
  noStroke();
  noCursor();
  
  movie1 = new Movie(this, "Blogmix Dec 29 2016.mov");
  movie1.loop();
  s1 = 1.0;
  
   movie2 = new Movie(this, "q1.mov" );
  movie2.loop();
  s2 = 1.0;
 
  
  // Setting up midi controller
  MidiBus.list();  // Shows controllers in the console
  myBus = new MidiBus(this, "SLIDER/KNOB","CTRL");  // input and output
  
  for (int i = 16; i < 24; i++) {  // Sets only the knobs (16-23) to be max @ start
    cc[i] = 127;
  }
  cc[17] = 2;  // Make only speed minimum at startup

  
 
}

void movieEvent(Movie m) {
  m.read();
}

void draw() {
  movie1.read();  
 movie2.read();
     
// BACKGROUND ALPHA CONTROL: for fade  
 // float BG_AlphaControl = map(cc[16],0,127,0,255);

// --------------------
// SPEED CONTROL: how often to change the word (if (frameCount % speed == 0...)) 
  //int speedControl = round(map(cc[17],0,127,30,2));  // Shouldn't be float b/c % 0
// --------------------
// LEFT AND RIGHT
  float image1X = map(cc[16], 0, 127, 0, width);
// --------------------

// UP AND DOWN
  float image1Y = map(cc[17], 0, 127, height, 0);
// --------------------

// --------------------
float image2X = map(cc[18],0,127,-10,width+10);
float image2Y = map(cc[19],0,127,-10,height+10);

float image1Opacity = map(cc[0],0,127,0,255);
float image2Opacity = map(cc[1],0,127,0,255);

 float image1Size = map(cc[2],0,127,.1, 2.0); 
  float image2Size = map(cc[3],0,127,.1, 2.0); 
 
  float BG_AlphaControl = map(cc[4],0,127,0,255);   

 s1 = map(cc[5], 0,127,0.5, 2.0);
 s2 = map(cc[6], 0,127,0.5, 2.0);
  
  
// CHANGE BY frameCount
  //if (frameCount % speedControl == 0) {     // every n'th frame
    
    // BG fade layer draws whenever text draws
    fill(255, BG_AlphaControl);  // fills screen-sized rectangle (below) with white w/ opacity determined by midi
    rect(0,0,width,height);
   
    imageMode(CENTER);
    tint(255,image1Opacity);
    image(movie1, image1X, image1Y, width * image1Size, height * image1Size);
    movie1.speed( s1);
    
    tint(255,image2Opacity);
    image(movie2, image2X, image2Y, width * image2Size, height * image2Size);
     movie2.speed( s2);
    
//saveFrame("2movs###########.tiff");
  }
  






                       // midi #  (ex:) knob #    # from knob, mapped to be b/w 0 and 1
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

  cc[number] = value;  // saves the midi output # to be converted later for what we need

  if (cc[42] == 127) { // Press #42 to pause
   pauseToggle = !pauseToggle;
  }

  if (cc[45] == 127) { // Press #45 to save an image
    saveImage();       // See save function
  }
}

// Red toggle?
// Fade is still lurchy at low speeds
