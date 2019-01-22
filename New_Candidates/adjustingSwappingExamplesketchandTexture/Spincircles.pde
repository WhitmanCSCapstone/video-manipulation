class CIRCLE extends QUAD{
  float ry;
  float rx;
  void update(PGraphics p)
  {
    //p.smooth(8);
    p.noStroke();
    float bop = map(cc[21],0,127,255,5);
    p.fill(0,bop);
    p.rect(0,0,0,p.width,p.height);
    p.stroke(255);
    float w = map(cc[5],0,127,10,2);
    p.strokeWeight(w);
    p.translate(p.width / 2, p.height/2);
    float ma = map(cc[3], 0,127,0,65);
    float mb = map(cc[4], 0,127,0,65);
    p.rotateY (ry);
    ry = ry + ma;
    p.rotateX (rx);
    rx = rx + mb;
    p.beginShape();
    // tint(255,120);
    //texture(vid);
    float cw = map(cc[6],0,127,-p.height/2,p.height/2);
    float co = map(cc[7],0,127,255,5);
    float s = map(cc[22],0,127,.2,2);
    p.fill(0,co);
    p.ellipse(cw,0,p.height *s,p.height *s);
    p.vertex(-p.width/2, - p.height/2, 0, 0, 0);
    p.vertex(p.width/2, -p.height/2, 0, p.width, 0);
    p.vertex(p.width/2, p.height/2, 0, p.width, p.height);
    p.vertex(-p.width/2, p.height/2, 0, 0, p.height);
    p.endShape();
  }
  void setup(PApplet app, PGraphics p)
  {
    rx = 0.0;
    ry = 0.0;
    p.fill(0);
  }
}
