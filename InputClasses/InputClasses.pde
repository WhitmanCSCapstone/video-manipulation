import themidibus.*;
import java.util.*;

MidiBus myBus;

RAINBOW r;

InputController inputController;

PGraphics vid;

void setup(){
  
  size(1280,720, P3D);
  vid = createGraphics(1280,720,P3D);
  
  MidiBus.list();  // Shows controllers in the console
  myBus = new MidiBus(this, "SLIDER/KNOB","CTRL");
  
  r = new RAINBOW();
  
  inputController = new InputController(256, true, false);
  
  r.setup(this, vid);
}


void draw() {
  r.update(vid, inputController.fetchInputs());
}

void controllerChange(int channel, int number, int value) {
  println();
  println("Controller Change:");
  println("--------");
  println("Channel:"+channel);
  println("Number:"+number);
  println("Value:"+value);
  
  inputController.updateModel(number,(double)value);
  
}
