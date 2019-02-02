/*
  ColorMidi3DSupershapeTempStop: Generates a 3D image using midi controller. 
  This is accomplished by mapping a whole bunch of values to the arrays. 
  Visualization is done with peasycam. 
  There is a lot of room for optimizing and fine tuning.
  Ask Justin where he got this code. It would be cool for sliders to control camera.
  https://www.youtube.com/watch?v=akM4wMZIBWg
*/
import themidibus.*;
float cc[];
MidiBus myBus;

Supershape superShape;

void setup(){
  size(1280,800,P3D);
  MidiBus.list();  // Shows controllers in the console
  myBus = new MidiBus(this, "SLIDER/KNOB","CTRL");  // input and output g:-- Changed from SLIDER/KNOB for windows
  cc = new float[256];
  superShape = new Supershape();
}

void draw(){
  superShape.display(cc[16],cc[17],cc[18],cc[19]);
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
