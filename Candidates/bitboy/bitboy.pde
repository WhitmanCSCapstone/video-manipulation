/*
  Bitboy: Black and white camera view, resolution changes based on amplitude of input audio file.
*/

import processing.video.*;
PShader shader;
Capture cam;
import processing.sound.*;
SoundFile song;
Amplitude amp;

void setup() {
  size(1920, 1080, P2D); //g: This may require changing to match a resolution of your screen or camera.
  shader = loadShader("pixelate.glsl");
  cam = new Capture(this);
  cam.start(); //g: REQUESTED resolution not supported by capture device -- deleted resolution and framerate
  song = new SoundFile(this, "STE-000.mp3"); //g: There is a noticable delay during this line.
  song.loop();
  amp = new Amplitude(this);
  amp.input(song);
}

void draw() {
  if(cam.available() == true){
    cam.read();
  }
  else
    print("Camera not available");
  shader.set("step", map(amp.analyze(), 0.001, 0.6, -4, 4)/float(width), map(amp.analyze(), 0.001, 0.2, .1, .5)/float(height) );
  shader.set("srcTex", cam);
  shader(shader);
   
  rect(0, 0, width, height);
  filter(THRESHOLD);
}
