import themidibus.*;
import java.util.*;
import ddf.minim.*;
import ddf.minim.analysis.*;

MidiBus myBus;

RAINBOW r;

InputController inputController;

PGraphics vid;
PImage bob;

int width;
int height;

boolean midiFlag;
boolean soundFlag;

void setup(){
  height = 1280;
  width = 720;

  midiFlag = true;
  soundFlag = true;

  vid = createGraphics(height,width,P3D);
  size(1280,720, P3D);
  bob = new PImage(1280,720);
  
  MidiBus.list();  // Shows controllers in the console
  myBus = new MidiBus(this, "SLIDER/KNOB","CTRL");
  
  r = new RAINBOW();
  
  inputController = new InputController(this, 256, midiFlag, soundFlag);
  
  r.setup(vid);
}


void draw() {
  beginShape();
  vid.beginDraw();
  r.update(vid, inputController.fetchInputs());
  vid.endDraw();
  texture(vid);
  endShape();
  vertex(-vid.width, -vid.height, 0, 0, 0);
  vertex(vid.width, -vid.height, 0, vid.width, 0);
  vertex(vid.width, vid.height, 0, vid.width, vid.height);
  vertex(-vid.width, vid.height, 0, 0, vid.height);
  endShape();}

void controllerChange(int channel, int number, int value) {
  println();
  println("Controller Change:");
  println("--------");
  println("Channel:"+channel);
  println("Number:"+number);
  println("Value:"+value);
  
  inputController.updateModel(number,(float)value);
  
}
