// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// A random walker class!

class Walker {
  PVector position;

  PVector noff;

  Walker() {
    position = new PVector(width/2, height/2);
    noff = new PVector(random(1000),random(1000));
  }

  void display() {
    //strokeWeight(2);
    fill(127);
     color c = cam.get((int)(position.x*3),(int)(position.y*3));
       float fo = map(cc[19],0,127,10,255);
  fill(c,fo);
  float so = map(cc[21],0,127,0,255);
    stroke(0,so);
    //noStroke();
    float sz = map(cc[18],0,127,18,36);
    ellipse(position.x*3, position.y*3, sz, sz);
  }

  // Randomly move up, down, left, right, or stay in one place
  void walk() {
    
    position.x = map(noise(noff.x),0,1,-100,1280);
    position.y = map(noise(noff.y),0,1,-100,700);
    float nfx = map(cc[16],0,127,.0001,.01);
      float nfy = map(cc[17],0,127,.0001,.01);
    noff.x += nfx;
    noff.y += nfy;
    position.x = constrain(position.x, 0, width);
    position.y = constrain(position.y, 0, height);
  }
}
