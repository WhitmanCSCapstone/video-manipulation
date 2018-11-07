import themidibus.*;

Drip[] drips = new Drip[150];

void set1() {
 for(int i=0; i<drips.length; i++) {
   drips[i] = new Drip(random(width), 20, int(random(255)), int(random(255)), int(random(255)), width/100+random(width/40), random(width/30,width/8));
 }
}

void update(PGraphics p) {
  p.noStroke();
  
  float redBG = map(cc[0],0,127,0,255);   //
  float greenBG = map(cc[1],0,127,0,255); //  BG color on first 3 sliders
  float blueBG = map(cc[2],0,127,0,255);  //
  float alpha = map(cc[16],0,127,0,255);
  p.fill(redBG, greenBG, blueBG, alpha);
  p.rect(0, 0, width, height);
  
  int divisor = int(map(cc[17],0,127,50,1));
  
  for(int i=0; i<drips.length; i++) {
   drips[i].fall(p, i/divisor, map(cc[18],0,127,-1,1));  // Dial #18 controls direction
  }
}