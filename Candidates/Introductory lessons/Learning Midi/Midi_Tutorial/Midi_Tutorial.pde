/*
"Rainbow Etch A Sketch" Midi Tutorial

This is a tutorial to set up a Midi device and use it to change variables while a sketch is running.
You can map the controller output (0-127) to whatever variable parameters you want.

Written by Mercer Hanau under direction of Justin Lincoln, 7/19/2016
*/

import themidibus.*; //Import the library
float cc[] = new float[256];  // cc stands for controller change. This is the array of buttons, knobs, sliders, etc.  
                              //    on your midi device. 256 is more than we need, which is okay.
MidiBus myBus; // The MidiBus

float screenW = 0;       // screen width
float screenH = 0;       // screen height
float sideMargin = 0;    // Side margins
float topMargin = 0;     // top margin
float bottomMargin = 0;  // bottom margin

// These will all be controlled by the midi in the draw loop. They're just initialized here.
float xPos = 0;          // X position of the pen
float yPos = 0;          // Y position of the pen
float penSize = 0;         // "Pen" size
float red, green, blue;  // Pen color variables


void setup() {
  
  // Red Etch A Sketch frame
  size(850,700);
  noStroke();
  background(220,0,0);
  
  // White knobs
  fill(255);
  ellipse(width/12, height-height/10, height/7, height/7);
  ellipse(width-width/12, height-height/10, height/7, height/7);
  
  // Gray "screen"
  screenW = width*0.75;         // screen width
  screenH = height*0.65;        // screen height
  sideMargin = width*0.125;     // Side margins
  topMargin = height*0.125;     // top margin
  bottomMargin = height*0.225;  // bottom margin
  fill(200);
  rect(sideMargin, topMargin, screenW, screenH);
  
  // Makes the program think the xPos and yPos knobs are at 1 instead of default 0 at start until they are moved
  // (This is because if they're defaulted to 0, a dot appears outside the drawing frame and it cannot be cleared by the screen eraser.)
  cc[16] = 1;
  cc[17] = 1;

  MidiBus.list(); // List all available Midi devices by index and name in the console

// Tell it which Midi to use for input and output. (You may have to try a few options, but this one worked for ours.)
  //                 Parent    In          Out
  //                   |       |            |
  myBus = new MidiBus(this, "SLIDER/KNOB","CTRL"); // Create a new MidiBus
}


void draw() {
  
  // Map the parameters you need to the midi output
  // In this case, that's the x- and y-coordinates of the pen mapped to the range of midi outputs, 0-127
  
  //                 lowest output   
  //              knob #   | highest output   lowest parameter    highest parameter
  //                 |     |   |                |                       | 
  float xPos = map(cc[16], 0, 127, sideMargin+2*penSize, width-sideMargin-2*penSize);
  float yPos = map(cc[17], 0, 127, height-bottomMargin-2*penSize, topMargin+2*penSize);
  
  // Change the pen size with the third knob
  penSize = map(cc[18], 0, 127, 2, 20);
  
  // Map the pen's RGB color values to the output from the first 3 sliders on the left. (Otherwise black by default)
  red = map(cc[0],0,127,0,255);
  green = map(cc[1],0,127,0,255);
  blue = map(cc[2],0,127,0,255);
  fill(red, green, blue);
  
  ellipse(xPos, yPos, penSize, penSize);  // the "pen"  
  
  // Push "set" (button # 60 on the midi) to erase/reset the screen
  if (cc[60] == 127) {   
    fill(200);
    rect(sideMargin, topMargin, screenW, screenH);
  }
}

//                  which midi device    which knob/slider/button    output that gets mapped
//                          |                      |                      |
void controllerChange(int channel,           int number,              int value) {
  // Receive a controllerChange
  
  // These print lines are not important to running the program, but they can help for trouble shooting 
  //  or finding the number/value of a knob/button/etc.
  println();
  println("Controller Change:");  //
  println("--------");            //
  println("Channel:"+channel);    //  These print data from the midi controller in the console.
  println("Number:"+number);      //
  println("Value:"+value);        //
  println("Pen size:"+penSize);   //
  
  // This line is important!
  // It saves the midi output value into the array for the correct button/slider/knob #
  // It makes the program remember the value of each knob even when it's not being changed
  cc[number] = value;  

}