/*
  Cam_4quarterMirror2: Draws the camera view mapped so the mouse is a corner of 4 different views. 
  Bottom views are upsidedown. 
  Side views are flipped.
*/
import processing.video.*;

Capture cam;

void setup() {
  //size(1280, 800, P2D);
  fullScreen(P2D);
  cam = new Capture(this, 640,480);
  cam.start();
  noStroke();
}
void draw() {
  if (cam.available() == true) {
    cam.read();
  }
  float xx = mouseX;
  float yy = mouseY;
  // left top
  beginShape();
  texture(cam);
  
  //left right
  vertex(0, 0, cam.width, 0);
  vertex(xx, 0, 0, 0);
  vertex(xx, yy, 0, cam.height);
  vertex(0, yy, cam.width, cam.height);
  endShape();
  
  //left bottom
  beginShape();
  texture(cam);
   vertex(0, yy, cam.width, cam.height);
  vertex(xx, yy,0, cam.height);
  vertex(xx, height, 0, 0);
  vertex(0, height, cam.width, 0);
  endShape();
  
  //right bottom
   beginShape();
  texture(cam);
   vertex(xx, yy, 0, cam.height);
  vertex(width, yy,cam.width, cam.height);
  vertex(width, height, cam.width, 0);
  vertex(xx, height, 0,0);
  endShape();
  
  //top right
  beginShape();
  texture(cam);
  vertex(xx, 0, 0, 0);
  vertex(width, 0, cam.width, 0);
  vertex(width, yy, cam.width, cam.height);
  vertex(xx, yy, 0, cam.height);
  endShape();
}
