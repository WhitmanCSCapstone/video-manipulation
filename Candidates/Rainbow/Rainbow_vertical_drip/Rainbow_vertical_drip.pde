/*
  Rainbow like drops fall vertically. Changing the mouse location has effects on the alpha
  and speed at which they fall. Noticable roughness when alpha is low and speed is high.
*/
//Early attempt to learn OOP w/ Mercer Hanau. Useful for several other sketches.
randomcolor[] randomcolors = new randomcolor[150];

void setup() {  // The "factory" -- g:factory is misleading here, not a factory by CS standards
 //size(800, 600);
 fullScreen();

 for(int i=0; i<randomcolors.length; i++) {
   randomcolors[i] = new randomcolor(random(width), 20, int(random(255)), int(random(255)), int(random(255)), width/100+random(60), random(100,250));
 }

}

void draw() {
  //background(255);
  noStroke();
  float alpha = map(mouseX, 0, width, 0, 255);
  fill(255, alpha);
  rect(0, 0, width, height);
  
  int divisor = int(map(mouseY, 0, height, 2, 20));
   
   
  //Note from George: changing the number of circles has strange effects on the speed. Probably worth changing.
  for(int i=0; i<randomcolors.length; i++) {
   randomcolors[i].drive(i/divisor);
  }
}