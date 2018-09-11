import processing.video.*;

Movie vid;

void setup() {
  //size(1280, 800, P2D);
  fullScreen(P2D);
  vid = new Movie(this, "nnn.mov");
  vid.loop();
  noStroke();
}
void draw() {
  if (vid.available() == true) {
    vid.read();
  }

  float xx = mouseX;
  float yy = mouseY;
  // left top
  beginShape();
  texture(vid);
  // text(x, y, tx, ty);
  vertex(0, 0, vid.width, 0);
  vertex(xx, 0, 0, 0);
  vertex(xx, yy, 0, vid.height);
  vertex(0, yy, vid.width, vid.height);
  endShape();
  
  //left bottom
  beginShape();
  texture(vid);
   vertex(0, yy, vid.width, vid.height);
  vertex(xx, yy,0, vid.height);
  vertex(xx, height, 0, 0);
  vertex(0, height, vid.width, 0);
  endShape();
  
  //right bottom
   beginShape();
  texture(vid);
   vertex(xx, yy, 0, vid.height);
  vertex(width, yy,vid.width, vid.height);
  vertex(width, height, vid.width, 0);
  vertex(xx, height, 0,0);
  endShape();
  
  //top right
  beginShape();
  texture(vid);
  vertex(xx, 0, 0, 0);
  vertex(width, 0, vid.width, 0);
  vertex(width, yy, vid.width, vid.height);
  vertex(xx, yy, 0, vid.height);
  endShape();
  
  // Preview the whole image
  //image(cam, 0, 0, cam.width/8, cam.height/8);
}
