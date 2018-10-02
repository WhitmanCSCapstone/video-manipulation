//import processing.video.*;
import themidibus.*;
float cc[] = new float[256];

MidiBus myBus;
boolean midiPresent;

//Movie vid;
float ry = 0.0;

void setup(){
  size(1280,800,P3D);

  //*MIDI ADDED
  // Shows controllers in the console
  MidiBus.list();
  myBus = new MidiBus(this, "SLIDER/KNOB","CTRL");
  midiPresent = true;
  if (myBus.attachedInputs().length > 0){
    midiPresent = true;
  }
  else {
    midiPresent = false;
  }
    
  cc[17] = 0;
  cc[18] = 0;

  //vid = new Movie(this, "uuu.mov");
  //vid.loop();
  //noStroke()
 strokeWeight(.01);
 rectMode(CENTER);
}

void draw(){
 float ma;
 float mb;
 fill(255,5);
 rect(width/2,height/2,width,height);
  //fill(0,10);
  //rect(0,0,0,width,height);
  translate(width / 2, height/2);
 // if (vid.available() == true) {
    //vid.read();
  //}
  
//INPUT CLASS
  if(mousePressed){
   ma = map(mouseX, 0,width,0,.65);
   mb = map(mouseY, height,0,0,.65);
   rotateY (ry);
   ry = ry + ma;
   rotateX (mb);
  }
  else if (midiPresent) {
    ma = map(cc[17], 0,width,0,.65);
    mb = map(cc[18], 127,0,0,65);
    rotateY (ry);
    ry = ry + ma;
    rotateX (mb);
  }
  scale(220);
  TexturedCube();
}

void TexturedCube() {
  stroke(0,150);
  beginShape(QUADS);
  noFill();
  // Given one texture and six faces, we can easily set up the uv coordinates
  // such that four of the faces tile "perfectly" along either u or v, but the other
  // two faces cannot be so aligned.  This code tiles "along" u, "around" the X/Z faces
  // and fudges the Y faces - the Y faces are arbitrarily aligned such that a
  // rotation along the X axis will put the "top" of either texture at the "top"
  // of the screen, but is not otherwised aligned with the X/Z faces. (This
  // just affects what type of symmetry is required if you need seamless
  // tiling all the way around the cube)
  
  // +Z "front" face
  vertex(-1, -1,  1, 0, 0);
  vertex( 1, -1,  1, 1, 0);
  vertex( 1,  1,  1, 1, 1);
  vertex(-1,  1,  1, 0, 1);

  // -Z "back" face
  vertex( 1, -1, -1, 0, 0);
  vertex(-1, -1, -1, 1, 0);
  vertex(-1,  1, -1, 1, 1);
  vertex( 1,  1, -1, 0, 1);

  // +Y "bottom" face
  vertex(-1,  1,  1, 0, 0);
  vertex( 1,  1,  1, 1, 0);
  vertex( 1,  1, -1, 1, 1);
  vertex(-1,  1, -1, 0, 1);

  // -Y "top" face
  vertex(-1, -1, -1, 0, 0);
  vertex( 1, -1, -1, 1, 0);
  vertex( 1, -1,  1, 1, 1);
  vertex(-1, -1,  1, 0, 1);

  // +X "right" face
  vertex( 1, -1,  1, 0, 0);
  vertex( 1, -1, -1, 1, 0);
  vertex( 1,  1, -1, 1, 1);
  vertex( 1,  1,  1, 0, 1);

  // -X "left" face
  vertex(-1, -1, -1, 0, 0);
  vertex(-1, -1,  1, 1, 0);
  vertex(-1,  1,  1, 1, 1);
  vertex(-1,  1, -1, 0, 1);

  endShape();
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
