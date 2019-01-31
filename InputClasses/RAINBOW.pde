int cunter = 0;
class RAINBOW {
  Drip[] drips;

  void setup(PGraphics p) {
    print("Called rainbow setup");
    drips = new Drip[300];
    for(int i=0; i<drips.length; i++) {
      drips[i] = new Drip(random(p.width), 200, int(random(255)), int(random(255)), int(random(255)), p.width/100+random(p.width/40), random(p.width/30,p.width/8));
    }
  }

  void update(PGraphics p, input inputs[]) {
    // println("RAINBOW UPDATE");
    
    /*
    p.noStroke();
    
    float redBG = map(inputs[1],0,127,0,255);   //
    redBG += map(fftAvg,0,20,0,127);
    float greenBG = map(inputs[2],0,127,0,255); //  BG color on first 3 sliders
    greenBG += map(fftAvg,0,20,0,127);
    float blueBG = map(inputs[3],0,127,0,255);  //
    blueBG += map(fftAvg,0,20,0,127);
    float alpha = map(inputs[23],0,127,0,255);
    p.fill(min(redBG,255), min(greenBG,255), min(blueBG,255), alpha);
    p.rect(0, 0, p.width, p.height);
    
    int divisor = int(map(inputs[21],0,127,50,1));
    // println(drips.length); 150
    for(int i=0; i<drips.length; i++) {
      drips[i].fall(p, i/divisor, map(inputs[22],0,127,-1,1));  // Dial #18 controls direction
    }
    */
    
    noStroke();
  
    float redBG = map((float)inputs[0].getVal(),0,127,0,255);   //
    float greenBG = map((float)inputs[1].getVal(),0,127,0,255); //  BG color on first 3 sliders
    float blueBG = map((float)inputs[2].getVal(),0,127,0,255);  //
    float alpha = map((float)inputs[16].getVal(),0,127,0,255);
    p.fill(redBG, greenBG, blueBG, alpha);
    p.rect(0, 0, width, height);
  
    int divisor = int(map((float)inputs[17].getVal(),0,127,50,1));
  
    for(int i=0; i<drips.length; i++) {
      // println(cunter++);
      // println("calling the shitty fall function "+i+" input[18]: "+inputs[18].getVal());
      drips[i].fall(p,i/divisor, map((float)inputs[18].getVal(),0,127,-1,1));  // Dial #18 controls direction
    }
    
    
  }
}
