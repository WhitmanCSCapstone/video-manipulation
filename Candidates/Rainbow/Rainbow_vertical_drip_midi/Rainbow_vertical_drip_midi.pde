import themidibus.*;
float cc[] = new float[256];
MidiBus myBus;

Drip[] drips = new Drip[150];

void setup() {
// size(800,600);
 fullScreen();
 
 // Setting up midi controller
 MidiBus.list();  // Shows controllers in the console
 myBus = new MidiBus(this, "SLIDER/KNOB","CTRL");  // input and output
 
 for(int i=0; i<drips.length; i++) {
   drips[i] = new Drip(random(width), 20, int(random(255)), int(random(255)), int(random(255)), width/100+random(width/40), random(width/30,width/8));
 }
}

void draw() {
  noStroke();
  
  float redBG = map(cc[0],0,127,0,255);   //
  float greenBG = map(cc[1],0,127,0,255); //  BG color on first 3 sliders
  float blueBG = map(cc[2],0,127,0,255);  //
  float alpha = map(cc[16],0,127,0,255);
  fill(redBG, greenBG, blueBG, alpha);
  rect(0, 0, width, height);
  
  int divisor = int(map(cc[17],0,127,50,1));
  
  for(int i=0; i<drips.length; i++) {
   drips[i].fall(i/divisor, map(cc[18],0,127,-1,1));  // Dial #18 controls direction
  }
}


void controllerChange(int channel, int number, int value) {
// Receive a controllerChange
println();
println("Controller Change:");
println("--------");
println("Channel:"+channel);
println("Number:"+number);
println("Value:"+value);
//this.value = value;       // "this" refers (in Porcessing) to variables in the global space if this function is in the global space
//this.number = number;     // Took these out b/c not reliable (mixed tutorials badly)
//cc[number] = map(value, 0, 127, 0, 1);
cc[number] = value;  // saves the midi output # to be converted later for what we need
}