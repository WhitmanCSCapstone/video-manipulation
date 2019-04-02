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




public static final MidiMapper inputMap = new MidiMapper();


//input filenames. Change which files are used for video, audio, text, fonts, etc.
public static final String MP3_NAME = "s.mp3";
String RECORDED_VIDEO = "less.mp4";
String[] FONT_FILES = {"Helvetica-500.vlw", "Impact-500.vlw"};


//Used for button lighting
boolean midiSwitches[];


MasterController master;

void setup() {
  size(1280, 800, P3D);
  master = new MasterController(this);
  master.switchQuad(0);

}

void draw() {
  master.drawQuad();
}
