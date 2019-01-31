import processing.video.*;

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
      
      Stopping. 
      SPEED AND FADE MORE IMPORTANT
*/

import themidibus.*;
import java.util.*;
float cc[] = new float[256];
boolean bb[] = new boolean[256]; //array representing "on" state of board
import ddf.minim.analysis.*;
import ddf.minim.*;
Minim       minim;
                                                   AudioInput  in;
FFT         fft;
float deadzone = 4; //This is the deadzone for the controller. This gives a range of 8 where the controller will read 63.5.
MidiBus myBus;
Capture cam;
import processing.video.*;
Movie mov;
PGraphics vid;
import processing.sound.AudioIn;
import processing.sound.Amplitude;
import processing.sound.SoundFile; //I'm overwriting the imports in some cases, order matters
float inc = 0;
float amplitude = 0.05;
float frequency = 20.0;
AudioIn mic;
Amplitude amp;
AudioPlayer kick;
float smoothing = .85; // Creates delay with the fft transform. optimal ranges is .8 - .95 IMO change with arrow keys 
float[] fftReal;
float[] fftImag;
float[] fftSmooth;
int specSize;
int targetFreq = 10; // Low is for lower frequencies
int bandwidth = 20; //Width of frequency band, larger is a smoother responce
float fftAvg = 0;
boolean isLive = false;
float rx = 0.0;
float ry = 0.0;
float mx = 0.0;
float my = 0.0;

//This begins by displaying No sketches.
boolean s1 = false;
boolean s2 = false;
boolean s3 = false;
PImage img;
//BIT b;
//CHANGINGFONTS cf;
RAINBOW r;
SLATS s;
UCAM uc;
List<QUAD> quads;

void setup() {
  size(1280,720, P3D);
  MidiBus.list();  // Shows controllers in the console
  myBus = new MidiBus(this, "SLIDER/KNOB","CTRL");  // input and output
  // g: nanoKONTROL2 is something I added here. Previously it said SLIDER/KNOB, CTRL. Possible need for WINdows compatibility and checking OS at launch.
  // Second parameter is output, necessary for setting lights of the knob.

  
  vid = createGraphics(1280,720,P3D);
  img = loadImage("background.png"); 
  
  noStroke();
  background(0);

  //Here are some objects which represent sketches being drawn to the quad.
  //b = new BIT();
  //cf = new CHANGINGFONTS();
  r = new RAINBOW();
  s = new SLATS();
  //uc = new UCAM();
  //We add them to the quad array to call them in the same way.
  quads = new ArrayList<QUAD>();
  //quads.add(b);
  //quads.add(cf);
  quads.add(r);
  quads.add(s);

  for(int i = 0;i<quads.size();i++)
  {
    quads.get(i).setup(this,vid); // Not all sketches use the PApplet or PGraphics parameter but it doesn't hurt to pass them around
  }
  //quads.add(uc);
  minim = new Minim(this); //minum works better for fft I think, it is also easier to swap between prerecorded and live audio
  //I have noticed a delay in live audio though, which isn't seen when a mp3 is used.
  in = minim.getLineIn(Minim.STEREO, 512);
  kick = minim.loadFile("hydrogen.mp3", // filename
                            1024      // buffer size
                         );
                         if ( kick == null ) println("Didn't get kick!");
  if(isLive){
    fft = new FFT(in.bufferSize(), in.sampleRate());
  }
  else
  {
    kick.loop();
    fft = new FFT(kick.bufferSize(), kick.sampleRate());
  }
  specSize = fft.specSize();
  fftSmooth = new float[specSize];
  fftReal   = new float[specSize];
  bb[45] = isLive;  //Allows for controller updating on program start, so the controller always reflects on state
                    //Can be adapted to other properties in future 
  if(bb[45])
    myBus.sendControllerChange(0,45,127); //true
  else
    myBus.sendControllerChange(0,45,0); //false
  for (int i = 16; i < 19; i++) {  // Sets only the knobs (16-19) to be med @ start
   cc[i] = 127/2;
  }
  cc[20] = 127;//fade off to start
  //Last 3 knobs start at 0
}

float doFFT(){
  
  smoothing = map(cc[7],0,127,0.0,1.0); //Controls FFT smoothing
  if(bb[45])//isLive
    fft.forward(in.left);
  else
    fft.forward(kick.mix);
  //fftReal = fft.getSpectrumReal();
  //fftImag = fft.getSpectrumImaginary();
  for(int i = 0; i < specSize; i++)
  {
    float band = fft.getBand(i);
    fftSmooth[i] *= smoothing;
    if(fftSmooth[i] < band) 
      fftSmooth[i] = band;
  }

  float sum = 0;

  for(int i = max(targetFreq - bandwidth/2,0); i <= targetFreq+bandwidth/2 || i>=specSize;i++)
  {
    sum += fftSmooth[i];
  }
  return sum/bandwidth;
}

void draw() {
  //This is where we would call the master controller

  fftAvg = doFFT(); //Generally ranges between 1 or 2 and 20 for the song I chose
  float adjust = 0;
  float fillOpacity =  map(cc[20], 0, 127,0, 255);
  if(bb[52])//FFt for fade
  {
    adjust = map(fftAvg,0,60,0,255);
  }
  tint(255,min(fillOpacity+adjust,255));
  translate(width / 2, height/2);
  adjust = 0;

  float xskew = map(cc[16],0,127,radians(0),radians(360));
  mx = map(cc[17], 0,127,-.2,.2);
  if(bb[48])
    xskew += map(fftAvg,0,20,0,PI/16); //offset for fft x 
  if(bb[49])
    adjust += map(fftAvg,0,20,-PI/64,PI/64);//rotation
  rotateX (rx + adjust + xskew);
  rx += mx + adjust;
  adjust = 0;
  
  float yskew = map(cc[18], 0,127,radians(0),radians(360));
  my = map(cc[19], 0,127,-.2,.2);
  if(bb[50])
    yskew += map(fftAvg,0,20,0,PI/16); //offset for fft y 
  if(bb[51])
    adjust = map(fftAvg,0,20,-PI/64,PI/64); //y rotation
  rotateY(ry + adjust + yskew);
  ry += my + adjust;
  adjust = 0;

  //Z rotation currently disabled
  // float rZ = map(cc[19], 0,127,radians(0),radians(360));
  // if(bb[51])
  //   adjust = map(fftAvg,0,20,0,PI/8); //offset for fft z
  // rotateZ(rZ+adjust);
  // adjust = 0;

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

  if(bb[64]) //zoom
    adjust = map(fftAvg,0.0,20.0,0.0,40.0); //zoom mapped to fft
  camera(width/2, height/2, (height/2) / tan(PI/map(cc[0]+adjust,0,127,8, 4)), width/2, height/2, 0, 0, 1, 0);
  //background(bigColor);
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
    if (number == 32){
       s2 = !s2;
       //s1=false;
       //s3=false;
    }
    else if(number == 33){
        s1 = !s1;
        //s2=false;
        //s3=false;
    }
    else if(number == 34){
     s3 = !s3;
     //Pauses and plays the video
     if(!s3)
      s.cam.pause();
     else
       s.cam.play();
     //s1 = false;
     //s2=false;
    }
    else if(number == 45)//swapping live and recorded audio
    {
      isLive = bb[number];
      if(bb[number])
      {
        kick.pause(); //optionally pause the audio while switching to live sound
        fft = new FFT(in.bufferSize(), in.sampleRate());
      }
      else
      {
        kick.loop(); //optionally pause the audio while switching to live sound
        fft = new FFT(kick.bufferSize(), kick.sampleRate());
      }
      specSize = fft.specSize();
      fftSmooth = new float[specSize];
      fftReal   = new float[specSize];
    }
    else if(number == 62) //controlling the target frequency for the fft
    {
      targetFreq = min(500, targetFreq+10);
      println(targetFreq);
    }
    else if(number == 61)
    {
      targetFreq = max(0,targetFreq - 10);
      println(targetFreq);
    }
  }
  else{
   if(value > 63.5-deadzone && value < deadzone + 63.5)
   {
     cc[number] = 63.5;
   }
  }
}

void keyPressed(){
  float inc = 0.01;
  if(keyCode == UP && smoothing < 1-inc) smoothing += inc;
  if(keyCode == DOWN && smoothing > inc) smoothing -= inc;
}
