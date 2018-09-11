import processing.video.*;
PShader shader;
Capture cam;
import processing.sound.*;
SoundFile song;
Amplitude amp;

void setup() {
  size(1280, 800, P2D);
  shader = loadShader("pixelate.glsl");

 // String[] cameras = Capture.list();
 cam = new Capture(this, width, height, 30);
cam.start();
  song = new SoundFile(this, "9.wav");
  song.loop();
  amp = new Amplitude(this);
  amp.input(song);

 // noStroke();
}

void draw() {
  //if(cam.available() == true){
  // cam.read();
  cam.read();
 
  shader.set("step", map(amp.analyze(), 0.001, 0.6, -4, 4)/float(width), map(amp.analyze(), 0.001, 0.2, .1, .5)/float(height) );
  shader.set("srcTex", cam);

  shader(shader);
   
  rect(0, 0, width, height);
  filter(THRESHOLD);
}
