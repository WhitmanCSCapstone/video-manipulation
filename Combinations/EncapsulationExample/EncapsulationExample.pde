import themidibus.*;
float cc[] = new float[256];
float dd[] = new float[256];
MidiBus myBus;

Drip[] drips = new Drip[3];
Supershape s = new Supershape(40,40);
boolean switcher = false;

void setup() {
  size(1920,1080,P3D);
  // Setting up midi controller
  MidiBus.list();  // Shows controllers in the console
  myBus = new MidiBus(this, "nanoKONTROL2","CTRL");  // input and output

  for(int i=0; i<drips.length; i++) {
    drips[i] = new Drip(random(width), random(height),s);
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
  
  int divisor = int(map(cc[17],0,127,1,10));
  
  for(int i=0; i<drips.length; i++) {
    drips[i].fall(divisor, new PVector(map(cc[18],0,127,-1,1),map(cc[19],0,127,-1,1)));  // Dial #18 controls direction
  }
}

void mousePressed() {
  Drip b = new Drip((float)mouseX,(float)mouseY,s));
  drips.append(b);
}

void controllerChange(int channel, int number, int value) {
  // Receive a controllerChange
  println();
  println("Controller Change:");
  println("--------");
  println("Channel:"+channel);
  println("Number:"+number);
  println("Value:"+value);
  if(number == 32 && value == 127)
    switcher = !switcher;
  if(!switcher)
  {
    print("Drops");  
    cc[number] = value;  // saves the midi output # to be converted later for what we need
  }
  else{
    dd[number] = value;
    print("Shapes");
    for(int i=0; i<drips.length; i++) {
      drips[i].updateArray();  // Dial #18 controls direction
    }
  }
}
