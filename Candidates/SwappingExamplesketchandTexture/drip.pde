class RAINBOW extends QUAD{
  Drip[] drips;

  void setup(PApplet app, PGraphics p) {
    print("Called rainbow setup");
    drips = new Drip[150];
    for(int i=0; i<drips.length; i++) {
      drips[i] = new Drip(random(p.width), 200, int(random(255)), int(random(255)), int(random(255)), p.width/100+random(p.width/40), random(p.width/30,p.width/8));
    }
  }

  void update(PGraphics p) {
    // println("RAINBOW UPDATE");
    p.noStroke();
    
    float redBG = map(cc[1],0,127,0,255);   //
    float greenBG = map(cc[2],0,127,0,255); //  BG color on first 3 sliders
    float blueBG = map(cc[3],0,127,0,255);  //
    float alpha = map(cc[23],0,127,0,255);
    p.fill(redBG, greenBG, blueBG, alpha);
    p.rect(0, 0, p.width, p.height);
    
    int divisor = int(map(cc[21],0,127,50,1));
    // println(drips.length); 150
    for(int i=0; i<drips.length; i++) {
      drips[i].fall(p, i/divisor, map(cc[22],0,127,-1,1));  // Dial #18 controls direction
    }
  }
}