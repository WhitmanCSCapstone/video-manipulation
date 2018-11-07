/*
  Some changes:
    The knobs controlling the rainbow drip have been changed to the last 3. (dir1,dir2,alpha)
    Code supports lighting up the midi controller. (Let me know if it no longer works the other way)
      For lighting up the midi controller - Consider downloading the korg driver for nanoKONTROL2 at https://www.korg.com/us/support/download/software/0/159/1354/
      Open and connect to the controller, then click the northwest-most button. Change led mode to EXTERNAL.
      Changes in the code are in setting up the controller (needs an output), and when the controller is updated, send it a signal
    Drawing method has changed:
      Much more clear how sketches are drawn to the main video quad. 
      Sketches can be drawn over each other.
        In the case of sketches which draw to a background, their individual background alpha can be changed to overwrite others (to an extent)
          Currently there is a predefined order in which the sketches draw, it would not be hard to make that based on the order they are added via controller.
    
    TODO:
      Automate sketch translation to draw on a PGraphics object instead. 
      Add sound.
      Movie pausing and resuming is easy. Let me know if it is a priority to add it.
      Organizing which knobs control what is still up in the air. The text sketch here uses almost all the knobs. They can be consolidated to the last 3
        or there can be a button which controls what knobs are affecting what. Previously we considered that a limitation of the controller though. 
      Setting the first few knobs to what you wanted. Controls are still all over the place. 
      WE GOT LIGHTS WORKING THOUGH!
*/

import themidibus.*;
import java.util.*;
float cc[] = new float[256];
boolean bb[] = new boolean[256];

MidiBus myBus;
Capture cam;
import processing.video.*;
Movie mov;
PGraphics vid;
import processing.sound.*;
float inc = 0;
float amplitude = 0.05;
float frequency = 20.0;
AudioIn mic;
Amplitude amp;
float rx = 0.0;
float ma = 0.0;

//This begins by displaying the first sketch only.
boolean s1 = true;
boolean s3 = false;
boolean s2 = false;
PImage img;
//BIT b;
CHANGINGFONTS cf;
RAINBOW r;
SLATS s;
List<QUAD> quads;

void setup() {
  size(1280,720, P3D);
  MidiBus.list();  // Shows controllers in the console
  myBus = new MidiBus(this, "nanoKONTROL2","nanoKONTROL2");  // input and output
  // g: nanoKONTROL2 is something I added here. Previously it said SLIDER/KNOB. Possible need for WINdows compatibility and checking OS at launch.
  // Second parameter is output, necessary for setting lights of the knob.

  for (int i = 16; i < 24; i++) {  // Sets only the knobs (16-23) to be med @ start //THIS COULD REALLY BE OPTIMIZED
    cc[i] = 127/2;
  }

  vid = createGraphics(1280,720,P3D);
  img = loadImage("background.png"); 
  
  noStroke();
  background(0);

  //Here are some objects which represent sketches being drawn to the quad.
  //b = new BIT();
  cf = new CHANGINGFONTS();
  r = new RAINBOW();
  s = new SLATS();

  //We add them to the quad array to call them in the same way.
  quads = new ArrayList<QUAD>();
  //quads.add(b);
  quads.add(cf);
  quads.add(r);
  quads.add(s);

  for(int i = 0;i<quads.size();i++)
  {
    quads.get(i).setup(this,vid); // Not all sketches use the PApplet or PGraphics parameter but it doesn't hurt to pass them around
  }
}

void draw() {
  //This is where we would call the master controller 
  float fillOpacity =  map(cc[20], 0, 127,0, 255);
  tint(255,fillOpacity);
  translate(width / 2, height/2);
  
  ma = map(cc[17], 0,127,-.2,.2);
  rotateX (rx);
  rx += ma;
  float rY = map(cc[18], 0,127,radians(0),radians(360));
  rotateY(rY);
  float rZ = map(cc[19], 0,127,radians(0),radians(360));
  rotateZ(rZ);
  beginShape();
  if (s1)
  {
    vid.beginDraw();
    quads.get(0).update(vid);
    vid.endDraw();  
  }
  if(s2)
  {
   vid.beginDraw();
   quads.get(1).update(vid);
   vid.endDraw();
  }
  if(s3)
  {
   vid.beginDraw();
   quads.get(2).update(vid);
   vid.endDraw();
  }
  texture(vid);
  
  vertex(-600, -400, 0, 0, 0);
  vertex(600, -400, 0, vid.width, 0);
  vertex(600, 400, 0, vid.width, vid.height);
  vertex(-600, 400, 0, 0, vid.height);
  endShape();
  camera(width/2, height/2, (height/2) / tan(PI/map(cc[0],0,127,8, 4)), width/2, height/2, 0, 0, 1, 0);
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
  if(value == 127){//This is only on button down, this is 0 when releasing the key
    if(bb[number]) //bb represents the "on" value of a key. In this case, we send 0 to turn it off, effectively toggling it.
    {
      myBus.sendControllerChange(channel,number,0); 
      bb[number] = false;
    }
    else // Now we are moving from the off state to an on state.
    {
      bb[number] = true;
      myBus.sendControllerChange(channel,number,127); 
    }
  }
   
  if (value == 127){  //This can be used to toggle the controls or switch between them.
                      //If you want to only display a sketch when the key is held down, this is where you change that too.
                      //Right now, you can run them all at the same time, but if you uncomment the "falsifying code" it will disable of the other running sketches.
                      //You can also change the if value == 127 above to value == value, this will only show a sketch on holding down the button. 
    if (number == 8){
       s2 = !s2;
       //s1=false;
       //s3=false;
    }
    else if(number == 9){
        s1 = !s1;
        //s2=false;
        //s3=false;
    }
    else if(number == 10){
     s3 = !s3;
     //s1 = false;
     //s2=false;
    }
  }
}