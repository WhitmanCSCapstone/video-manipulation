/*
 SKIP RIGHT  is pause and play toggle, starts out paused. takes a sec to scale the picture. 
 should probably start leftmost knob in far left position, rest in middle. 
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
boolean soundLive = true;
boolean camLive = false;
float rx = 0.0;
float ry = 0.0;
float mx = 0.0;
float my = 0.0;

//This begins by displaying No sketches.
boolean s1 = true;
boolean s2 = false;
boolean s3 = false;
boolean s4 = false;
PImage img;
//BIT b;
CHANGINGFONTS cf;
RAINBOW r;
Supershape s;
UCAM uc;
CIRCLE cir;
MIDINOISEWALK mnw;
VIS vis;

List<QUAD> quads;
boolean pauseplay = false;
boolean reset = false;
boolean resumespin = false;
void loadBoard()
{
  bb[45] = soundLive;  //Allows for controller updating on program start, so the controller always reflects on state
                    //Can be adapted to other properties in future 
  bb[41] = camLive;
  bb[42] = reset;
  bb[32] = s1;
  bb[33] = s2;
  bb[34] = s3;
  bb[35] = s4;
  bb[44] = pauseplay;
  for(int i = 32; i < 72;i++) // Update sketches to reflect true state
  {
    if(bb[i])
      myBus.sendControllerChange(0,i,127); //true
    else
      myBus.sendControllerChange(0,i,0); //false
  }
  for (int i = 16; i < 20; i++) {  // Sets only the knobs (16-19) to be med @ start
   cc[i] = 63.5;
  }
  cc[16] = 0; //starts upright
  cc[20] = 127;//fade off to start
  //Last 3 knobs start at 0
  cc[18]=63.5;
  cc[0] = 120; //zoom
}
void setup() {
  size(3800,2100, P3D);
  String[] cameras = Capture.list();
    print(cameras);
  //fullScreen(P3D);
  MidiBus.list();  // Shows controllers in the console
  myBus = new MidiBus(this, "nanoKONTROL2","nanoKONTROL2");  // input and output
  // g: nanoKONTROL2 is something I added here. Previously it said SLIDER/KNOB, CTRL. Possible need for WINdows compatibility and checking OS at launch.
  // Second parameter is output, necessary for setting lights of the knob.
  
  vid = createGraphics(1280,720,P3D);
  img = loadImage("background.png"); 
  
  noStroke();
  background(0);

  //Here are some objects which represent sketches being drawn to the quad.
  //b = new BIT();
  //cf = new CHANGINGFONTS();
  //r = new RAINBOW();
  //s = new Supershape();
  vis = new VIS();
  //cir = new CIRCLE();
  //uc = new UCAM();
  //mnw = new MIDINOISEWALK();
  //We add them to the quad array to call them in the same way.
  quads = new ArrayList<QUAD>();
  //quads.add(b);
  //quads.add(cf);
  //quads.add(cir);
  //quads.add(mnw);
  //quads.add(r);
  //quads.add(uc);
  //quads.add(s);
  quads.add(vis);


  
  for(int i = 0;i<quads.size();i++)
  {
    quads.get(i).setup(this,vid); // Not all sketches use the PApplet or PGraphics parameter but it doesn't hurt to pass them around
  }
  //quads.add(uc);
  minim = new Minim(this); //minum works better for fft I think, it is also easier to swap between prerecorded and live audio
  //I have noticed a delay in live audio though, which isn't seen when a mp3 is used.
  in = minim.getLineIn(Minim.STEREO, 512);
  kick = minim.loadFile("maniac.mp3", // filename
                            1024      // buffer size
                         );
                         if ( kick == null ) println("Didn't get kick!");
  if(soundLive){
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
  loadBoard();
  //SETUP NEEDS TO BE CALLED IN CAM FOR THIS TO WORK BAD CODE!
  //if(camLive == false)
  //  mov.play();
}

float doFFT(){
  smoothing = map(cc[7],0,127,0.0,1.0); //Controls FFT smoothing
  if(bb[45])//soundLive
    fft.forward(in.left);
  else
    fft.forward(kick.mix);
  fftReal = fft.getSpectrumReal();
  fftImag = fft.getSpectrumImaginary();
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
  
  adjust = 0;
  if(!reset){
    translate(width / 2, height/2);
    float xskew = map(cc[16],0,127,radians(0),radians(360));
    mx = map(cc[17], 0,127,-.09,.09);
    if(bb[48])
      xskew += map(fftAvg,0,20,0,PI/16); //offset for fft x 
    if(bb[49])
      adjust += map(fftAvg,0,20,0,PI/64);//rotation
    rotateX (rx + adjust + xskew);
    rx += mx + adjust;
    adjust = 0;
    
    float yskew = map(cc[18], 0,127,radians(0),radians(360));
    my = map(cc[19], 0,127,-.09,.09);
    if(bb[50])
      yskew += map(fftAvg,0,20,0,PI/16); //offset for fft y 
    if(bb[51])
      adjust = map(fftAvg,0,20,0,PI/64); //y rotation
    rotateY(ry + adjust + yskew);
    ry += my + adjust;
    adjust = 0;
  
    //Z rotation currently disabled
    // float rZ = map(cc[19], 0,127,radians(0),radians(360));
    // if(bb[51])
    //   adjust = map(fftAvg,0,20,0,PI/8); //offset for fft z
    // rotateZ(rZ+adjust);
    // adjust = 0;
  }
  

  beginShape();
  if(s1)
  {
    vid.beginDraw();
    quads.get(0).update(vid,fftAvg);
    vid.endDraw();  
  }
  if(s2)
  {
   vid.beginDraw();
   quads.get(1).update(vid,fftAvg);
   vid.endDraw();
  }
  texture(vid);
  if(!reset){
    //CHANGE THESE FOR A BIGGER GRAPHICS BUFFER
    vertex(-600, -400, 0, 0, 0);
    vertex(600, -400, 0, vid.width, 0);
    vertex(600, 400, 0, vid.width, vid.height);
    vertex(-600, 400, 0, 0, vid.height);
  }
  else{
    vertex(0, 0, 0, 0, 0);
    vertex(width, 0, 0, vid.width, 0);
    vertex(width, height, 0, vid.width, vid.height);
    vertex(0, height, 0, 0, vid.height);
  }
  endShape();
  //CHANGE THESE FOR A BIGGER GRAPHICS BUFFER
  
  
  if(bb[64]) //zoom
    adjust = map(fftAvg,0.0,20.0,0.0,40.0); //zoom mapped to fft
  camera(width/2, height/2, (height/2) / tan(PI/map(cc[0]+adjust,0,127,8, 4)), width/2, height/2, 0, 0, 1, 0);
  //background(bigColor);
}

void controllerChange(int channel, int number, int value) {
  // Receive a controllerChange
  println();
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
       s1 = !s1;
       //s1=false;
       //s3=false;
    }
    else if(number == 33){
        s2 = !s2;
        //s2=false;
        //s3=false;
    }
    else if(number == 34){
     s3 = !s3;
     //s1 = false;
     //s2=false;
    }
    else if(number == 35){
     s4 = !s4;
     //s1 = false;
     //s2=false;
    }
    else if(number==44)
    {
     pauseplay = !pauseplay; 
     if(pauseplay)
       mov.play();
      else
      mov.pause();
       
    }
    else if(number == 41){
     camLive = bb[number];
     if(camLive)
     {
       mov.pause();
     }
     else
       mov.play();
     //s1 = false;
     //s2=false;
    }
    else if(number == 42)
    {
     reset = bb[42];
     resumespin = !reset;
    }
    else if(number == 45)//swapping live and recorded audio
    {
      soundLive = bb[number];
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
      targetFreq = min(20, targetFreq+1);
      println("Frequency:" +targetFreq);
    }
    else if(number == 61)
    {
      targetFreq = max(0,targetFreq - 1);
      println("Frequency:" +targetFreq);
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
