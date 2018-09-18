import processing.video.*;
PShader shader;
Capture cam;
import processing.sound.*;
SoundFile song;
Amplitude amp;

void setup() {
  size(1920, 1080, P2D);
  shader = loadShader("pixelate.glsl");

 // String[] cameras = Capture.list();
  cam = new Capture(this);
  cam.start(); //g: REQUESTED resolution not supported by capture device -- deleted resolution and framerate
  song = new SoundFile(this, "STE-000.mp3"); // g:sounds not working, I think it is device specific
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
