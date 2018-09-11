
//Early attempt to learn OOP w/ Mercer Hanau. Useful for several other sketches.
randomcolor[] randomcolors = new randomcolor[150];

void setup() {  // The "factory"
 //size(800, 600);
 fullScreen();
 
 for(int i=1; i<randomcolors.length; i++) {
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
  
  for(int i=1; i<randomcolors.length; i++) {
   randomcolors[i].drive(i/divisor);
  }
}
