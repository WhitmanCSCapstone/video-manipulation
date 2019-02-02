import themidibus.*;
import java.util.*;
import ddf.minim.*;
import ddf.minim.analysis.*;

MidiBus myBus;

//MAGIC CONSTANT VILLAGE (FOR MIDI)
public static final int LIVE_AUDIO = 45;
public static final int TARGET_FREQ_MIN = 62;
public static final int TARGET_FREQ_MAX = 61;
public static final int PLAY_VID = 34;
public static final int SMOOTHER = 7;

Map<Integer, Integer> KNOB_MAP;

Map<Integer, Integer> MIDI_MAP;

InputController inputController;

Supershape superShape;

boolean midiFlag;
boolean soundFlag;

void setup(){

  KNOB_MAP = new HashMap<Integer, Integer>();
  KNOB_MAP.put(32,16);
  KNOB_MAP.put(33,17);
  KNOB_MAP.put(34,18);
  KNOB_MAP.put(35,19);

  MIDI_MAP = new HashMap<Integer, Integer>();
  MIDI_MAP.put(16,0);
  MIDI_MAP.put(17,1);
  MIDI_MAP.put(18,2);
  MIDI_MAP.put(19,3);

  size(1280,800,P3D);
  MidiBus.list();  // Shows controllers in the console
  myBus = new MidiBus(this, "SLIDER/KNOB","CTRL");  // input and output g:-- Changed from SLIDER/KNOB for windows
  
  superShape = new Supershape();

  midiFlag = true;
  soundFlag = false;

  inputController = new InputController(this, 4, midiFlag, soundFlag);
}


void draw() {
  /*
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
  endShape();
  */
  /*
  for (int i=0; i<inputController.fetchInputs().length; i++){
    println("INPUT: "+inputController.fetchInputs()[i].getVal());
  } */
  superShape.display(inputController.fetchInputs());
}

void controllerChange(int channel, int number, int value) {
  println();
  println("Controller Change:");
  println("--------");
  println("Channel:"+channel);
  println("Number:"+number);
  println("Value:"+value);

  if (KNOB_MAP.get(number) != null){
    myBus.sendControllerChange(channel,number,0);
  }
  
  inputController.updateModel(number,(float)value);
  
}
