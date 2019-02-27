/*
 * Testing file while combining modules of the program
 */

import java.util.Arrays;
import java.util.ArrayList;
import java.io.FileNotFoundException;
import processing.video.*;

import themidibus.*;
import java.util.*;
import ddf.minim.*;
import ddf.minim.analysis.*;

import processing.sound.Amplitude;
import processing.sound.SoundFile;

MidiBus myBus;

//MAGIC CONSTANT VILLAGE (SPECIAL MIDI BUTTONS)
public static final int LIVE_AUDIO = 45;
public static final int TARGET_FREQ_MIN = 62;
public static final int TARGET_FREQ_MAX = 61;
public static final int PLAY_VID = 34;
public static final int SMOOTHER = 7;
public static final int INPUT_MIN = 0;
public static final int INPUT_MAX = 127;


//LIVE VIDEO FILE
public static final String MP3_NAME = "dog.mp3";

//Mapping of FFT buttons to corresponding knobs
Map<Integer, Integer> KNOB_MAP;

//Mapping of MIDI knobs to input array indices
Map<Integer, Integer> MIDI_MAP;

//Used for button lighting
boolean midiSwitches[];

//Input module
InputController inputController;

//Sketch module
Supershape superShape;

//boolean flags for turning on midi input or sound decorating
boolean midiFlag;
boolean soundFlag;
String RECORDED_VIDEO = "less.mp4";
int BUFFERHEIGHT = 800;
int BUFFERWIDTH = 1280;

QuadContainer quadCont;
MasterController master;

void setup() {
  size(1280,800,P3D);
  //temp setup behavior
  inputSetup();
  master = new MasterController(this);
  master.switchQuad(0);

}

void draw() {
  master.drawQuad();
//   System.out.println("draw call");
}


void controllerChange(int channel, int number, int value) {
  println("Controller Update:");
  println("  Controller Change:");
  println("  --------");
  println("  Channel:"+channel);
  println("  Number:"+number);
  println("  Value:"+value);

  fakeMidiView(channel, number, value); // when real midiview is made, put this call to mastercontroller
  
  //Update state of program
//   inputController.updateModel(number,(double)value);
  master.handleControllerChange(channel, number, value);
}


void fakeMidiView(int channel, int number, int value) {
  //Turn FFT buttons on or off, light up controller
  if (KNOB_MAP.get(number) != null){ //if button maps to knob
    int knobIndex = MIDI_MAP.get(KNOB_MAP.get(number)); //get knobs array slot
    boolean isListening = midiSwitches[knobIndex]; 
    if (value==127){
      if (!isListening){
        myBus.sendControllerChange(channel,number,value);
      }
      midiSwitches[knobIndex] = !isListening;
    }
    else if (!isListening){
      myBus.sendControllerChange(channel,number,value);
    }
  }
}

void inputSetup() {
  MidiBus.list();  // Shows controllers in the console
  myBus = new MidiBus(this, "SLIDER/KNOB","CTRL");
  //myBus = new MidiBus(this, "nanoKONTROL2","nanoKONTROL2"); //For Windows

  //Initialize sound buttons to input knobs
  KNOB_MAP = MidiMapper.buttonToKnob();
  MIDI_MAP = MidiMapper.buttonToArray();


  midiFlag = true; //Should depend on whether Midi Controller is found
  soundFlag = true;
  //Initialize sound buttons off
  midiSwitches = new boolean[MIDI_MAP.size()];
  for (int i=0; i<midiSwitches.length; i++){
    midiSwitches[i] = false;
  }

}
