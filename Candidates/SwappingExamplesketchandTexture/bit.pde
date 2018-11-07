/*
  Bitboy: Black and white camera view, resolution changes based on amplitude of input audio file.
*/

import processing.video.*;
PShader shader;

SoundFile song;

class BIT extends QUAD{
  void setup(PApplet app, PGraphics p) {
    //size(1920, 1080, P2D); //g: This may require changing to match a resolution of your screen or camera.
    shader = loadShader("pixelate.glsl");
    song = new SoundFile(app, "STE-000.mp3"); //g: There is a noticable delay during this line.
    song.loop();
    amp = new Amplitude(app);
    amp.input(song);
    print("Called bit setup");
    cam = new Capture(app, 1280,720);
    cam.start();
  }

  void update(PGraphics p) {
    if(cam.available() == true){
      cam.read();
    }
    shader.set("step", map(amp.analyze(), 0.001, 0.6, -4, 4)/float(p.width), map(amp.analyze(), 0.001, 0.2, .1, .5)/float(p.height) );
    shader.set("srcTex", cam);
    p.shader(shader);
    
    p.rect(0, 0, width, height);
    p.filter(THRESHOLD);
  }
}