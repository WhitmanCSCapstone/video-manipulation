// import themidibus.*;
// import java.util.*;
// import ddf.minim.*;
// import ddf.minim.analysis.*;

// import processing.sound.Amplitude;
// import processing.sound.SoundFile;
// //overwriting the imports in some cases, order matters (?)

// MidiBus myBus;

// //MAGIC CONSTANT VILLAGE (SPECIAL MIDI BUTTONS)
// public static final int LIVE_AUDIO = 45;
// public static final int TARGET_FREQ_MIN = 62;
// public static final int TARGET_FREQ_MAX = 61;
// public static final int PLAY_VID = 34;
// public static final int SMOOTHER = 7;
// public static final int INPUT_MIN = 0;
// public static final int INPUT_MAX = 127;

// //LIVE VIDEO FILE
// public static final String MP3_NAME = "dog.mp3";

// //Mapping of FFT buttons to corresponding knobs
// Map<Integer, Integer> KNOB_MAP;

// //Mapping of MIDI knobs to input array indices
// Map<Integer, Integer> MIDI_MAP;

// //Used for button lighting
// boolean midiSwitches[];

// //Input module
// InputController inputController;

// //Sketch module
// Supershape superShape;

// //boolean flags for turning on midi input or sound decorating
// boolean midiFlag;
// boolean soundFlag;

// void setup(){

//   //Initialize sound buttons to input knobs
//   KNOB_MAP = new HashMap<Integer, Integer>();
//   KNOB_MAP.put(32,16);
//   KNOB_MAP.put(33,17);
//   KNOB_MAP.put(34,18);
//   KNOB_MAP.put(35,19);

//   //Initialize input knobs to indices
//   MIDI_MAP = new HashMap<Integer, Integer>();
//   MIDI_MAP.put(16,0);
//   MIDI_MAP.put(17,1);
//   MIDI_MAP.put(18,2);
//   MIDI_MAP.put(19,3);

//   //Initialize Midi controller
//   size(1280,800,P3D);
//   MidiBus.list();  // Shows controllers in the console
//   myBus = new MidiBus(this, "SLIDER/KNOB","CTRL");
//   //myBus = new MidiBus(this, "nanoKONTROL2","nanoKONTROL2"); //For Windows
  
//   superShape = new Supershape();

//   midiFlag = true; //Should depend on whether Midi Controller is found
//   soundFlag = true;

//   inputController = new InputController(this, MIDI_MAP.size(), midiFlag, soundFlag);

//   //Initialize sound buttons off
//   midiSwitches = new boolean[MIDI_MAP.size()];
//   for (int i=0; i<midiSwitches.length; i++){
//     midiSwitches[i] = false;
//   }
// }

// void draw() {
//   inputController.refresh();
//   superShape.display(inputController.fetchInputs());
// }

// void controllerChange(int channel, int number, int value) {
//   println();
//   println("Controller Change:");
//   println("--------");
//   println("Channel:"+channel);
//   println("Number:"+number);
//   println("Value:"+value);

//   //Turn FFT buttons on or off, light up controller
//   if (KNOB_MAP.get(number) != null){
//     int knobIndex = MIDI_MAP.get(KNOB_MAP.get(number));
//     boolean isListening = midiSwitches[knobIndex];
//     if (value==127){
//       if (!isListening){
//         myBus.sendControllerChange(channel,number,value);
//       }
//       midiSwitches[knobIndex] = !isListening;
//     }
//     else if (!isListening){
//       myBus.sendControllerChange(channel,number,value);
//     }
//   }
  
//   //Update state of program
//   inputController.updateModel(number,(double)value);
// }
