class QUAD {
  
    
    void update(PGraphics p){
        p.beginShape();
        p.endShape();
    }

    void setup(PApplet app, PGraphics p)
    {
        cam = new Capture(app,"Yee.mov");
        p.beginShape();
        p.endShape();
    }

}
