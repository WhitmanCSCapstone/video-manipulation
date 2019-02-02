// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// A random walker class!

class Walker {
  PVector position;

  PVector noff;

  Walker(PGraphics p) {
    position = new PVector(p.width/2, p.height/2);
    noff = new PVector(random(1000),random(1000));
  }

  void display(PGraphics p) {
    //strokeWeight(2);
    p.fill(127);
    color c = cam.get((int)(position.x),(int)(position.y));
    float fo = map(cc[19],0,127,10,255);
    p.fill(c,fo);
    //println(position.x);
    //println(c);
    float so = map(cc[21],0,127,0,255);
    p.stroke(0,so);
    //noStroke();
    float sz = map(cc[18],0,127,18,36);
    p.ellipse(position.x, position.y, sz, sz);
  }

  // Randomly move up, down, left, right, or stay in one place
  void walk(PGraphics p) { 
    position.x = map(noise(noff.x),0,1,-100,p.width);
    position.y = map(noise(noff.y),0,1,-100,p.height);
    float nfx = map(cc[16],0,127,.0001,.01);
    float nfy = map(cc[17],0,127,.0001,.01);
    noff.x += nfx;
    noff.y += nfy;
    position.x = constrain(position.x, 0, p.width);
    position.y = constrain(position.y, 0, p.height);
  }
}
