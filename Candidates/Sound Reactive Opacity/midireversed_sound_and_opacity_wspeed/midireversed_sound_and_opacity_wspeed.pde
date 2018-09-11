import themidibus.*;
MidiBus myBus;
import processing.video.*;
import processing.sound.*;


AudioIn mic;
Amplitude amp;
Movie movie;
float sum,delay,sensitivity,mspeed;


void setup(){
//size(440,440);
fullScreen();
// Show available midi devices. Need the string here to correctly initialize
// the midi device.
//MidiBus.list();
//myBus = new MidiBus(this,"Real Time Sequencer","Real Time Sequencer");
myBus = new MidiBus(this, "SLIDER/KNOB","CTRL");
//fullScreen();
background(0);

movie = new Movie(this, "transit.mov");
  movie.loop();
  mic = new AudioIn(this,0);
mic.start();
amp = new Amplitude(this);
amp.input(mic);
sum=0;
delay=0.1;
sensitivity = 0.15;
  //noLoop();
}

void movieEvent(Movie m) {
  m.read();
}

void draw(){
 fill(0);
 rect(0,0,width,height);
 //sensitivity=map(cc[16],0,127,0.01,0.3);
 sum+=(amp.analyze()-sum)*delay;
  float opacity = map(sum,0,sensitivity,255,25);
  //println("opacity = " + opacity);
  tint(255, opacity);
  movie.speed(mspeed);
    image(movie, 0, 0, width, height);
 
}

void controllerChange(int channel, int number, int value) {
  //println("number = " + number + ", value = " + value);
  if(number==16) {
    sensitivity=map(value,0,127,0.01,0.3);
    println("knob 16 = " + value);
  }
  if(number==17) {
    delay=map(value,0,127,0.05,0.3);
    println("knob 17 = " + value);
  }
   if(number==18) {
    mspeed=map(value,0,127,0.5,3.0);
    println("knob 18 = " + value);
  }
}
