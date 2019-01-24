/*
  keeptryingrotatingslats: First four midi knobs control the speed of rotating slats.
  They correspond top to bottom, first to last knob.
*/

class SLATS extends QUAD{
  float rx1 = 0.0;
  float rx2 = 0.0;
  float rx3 = 0.0;
  float rx4 = 0.0;
  float rx5 = 0.0;

  Movie cam;
  void setup(PApplet app, PGraphics p) {
    //size(1280, 800, P2D);
    
    cam = new Movie(app,"Yee.mov");
    cam.loop();
    noStroke();
    cam.pause();
  }
  
  void update(PGraphics p) {
    if (cam.available() == true) {
      cam.read();
    }
    p.pushMatrix();
    p.translate(0,height *.1,0);
    float ma = map(cc[16], 0,127,.0,.1);
    p.rotateX (rx1);
    rx1 = rx1 + ma;
    p.beginShape();
    p.texture(cam);
    p.vertex(0, 0, 0, 0);
    p.vertex(width, 0, cam.width,0);
    p.vertex(width, height*.2, cam.width, cam.height*.2);
    p.vertex(0, height *.2, 0, cam.height* .2);
    p.endShape();
    p.popMatrix();
    
    p.pushMatrix();
    p.translate(0,height *.3,0);
    float na = map(cc[17], 0,127,.0,.1);
    p.rotateX (rx2);
    rx2 = rx2 + na;
    p.beginShape();
    p.texture(cam);
    p.vertex(0, height*.2, 0, cam.height *.2);
    p.vertex(width, height *.2,cam.width, cam.height * .2);
    p.vertex(width, height * .4, cam.width, cam.height *.4);
    p.vertex(0, height * .4, 0, cam.height *.4);
    p.endShape();
    p.popMatrix();
    
    p.pushMatrix();
    p.translate(0,height *.5,0);
    float oa = map(cc[18], 0,127,.0,.1);
    p.rotateX (rx3);
    rx3 = rx3 + oa;
    p.beginShape();
    p.texture(cam);
    p.vertex(0, height * .4,0, cam.height *.4);
    p.vertex(width, height * .4, cam.width, cam.height *.4);
    p.vertex(width, height *.6, cam.width, cam.height *.6);
    p.vertex(0, height *.6, 0,cam.height *.6);
    p.endShape();
    p.popMatrix();
    
    p.pushMatrix();
    p.translate(0,height *.7,0);
    float pa = map(cc[19], 0,127,.0,.1);
    p.rotateX (rx4);
    rx4 =rx4 +pa;
    p.beginShape();
    p.texture(cam);
    p.vertex(0, height *.6, 0, cam.height * .6);
    p.vertex(width, height * .6, cam.width, cam.height * .6);
    p.vertex(width, height * .8, cam.width, cam.height * .8);
    p.vertex(0, height * .8, 0, cam.height * .8);
    p.endShape();
    p.popMatrix();
    
    p.pushMatrix();
    p.translate(0,height *.9,0);
    float qa = map(cc[20], 0,127,.0,.1);
    p.rotateX (rx5);
    rx5 =rx5 +qa;
    p.beginShape();
    p.texture(cam);
    p.vertex(0, height *.8, 0, cam.height * .8);
    p.vertex(width, height * .8, cam.width, cam.height * .8);
    p.vertex(width, height , cam.width, cam.height );
    p.vertex(0, height, 0, cam.height );
    p.endShape();
    p.popMatrix();
    
    // Preview the whole image
    //image(cam, 0, 0, cam.width/8, cam.height/8);
  }
}
