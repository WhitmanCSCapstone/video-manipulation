// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com
class MIDINOISEWALK extends QUAD{
  Walker[] w;
  int total = 0;

  void setup(PApplet app, PGraphics p) {
    String[] cameras = Capture.list();
    cam = new Capture(app, 1280,720);
    cam.start();
    w = new Walker[1000];
    for (int i = 0; i < w.length; i++) {
      w[i] = new Walker(p);
    }
    background(0);
  }

  void update(PGraphics p) {
    if(camLive){//Camera
      if (cam.available()) {
        cam.read();
      }
    }
    int o = int(map(cc[20],0,127,.001,10));
    noiseDetail(o,0.3);

    if (frameCount % 3 == 0) {
      total = total + 1;
      if (total > w.length-1) {
        total = w.length-1;
      }
    }

    for (int i = 0; i < total; i++) {
      w[i].walk(p);
      w[i].display(p);
    }
  }
}
