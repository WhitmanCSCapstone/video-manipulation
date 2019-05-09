////TODO nested loops.
////Another global comment
///*Multi
//Line
//Comment*/
//import processing.lib;
//import another.processing.lib;
//import themidibus.*;

//PVector [][] globe;

//float cc[] = new float[256];
//MidiBus myBus;
//float f1 = 0.01;
//int i1 = 1;
////Comment in global namespace
//void setup() {
//   size(200,200);
//   //Comment in setup()
//    myBus = new MidiBus(this, "SLIDER/KNOB","CTRL");  // input and output g:-- Changed from SLIDER/KNOB for windows
//       for (int i = 16; i < 24; i++) {  // Sets only the knobs (16-23) to be reasonable @ start - will still jump
//           cc[i] = 20;
//       }
//}
//int laterGlobal = 2;
//float globalWithComment = 3.0; // Comment on global
//String[] stringarray;
//void draw() {
//   /* Multi line comment in 
//   draw
//   */
//   float polycount = cc[16];
//   rect(mouseX,mouseY,10,10);/*Multi in one after text*/
//   i1 = i1 + 1;//Comment with {{}
//   //and with }}}
//   println(i1);
//}

////Comment that won't show up
//int anotherfunc(){
//   int x = 0;
//   return x;
//}

//float funcWithParams(float b)
//{//New line scope
//   return b;
//}
//PGraphics fifthGlobal;

//void controllerChange(int channel, int number, int value) {
// // Receive a controllerChange
// println();
// println("Controller Change:");
// println("--------");
// println("Channel:"+channel);
// println("Number:"+number);
// println("Value:"+value);
// println("Frame rate:"+frameRate);
// cc[number] = value;  // saves the midi output # to be converted later for what we need
//}
