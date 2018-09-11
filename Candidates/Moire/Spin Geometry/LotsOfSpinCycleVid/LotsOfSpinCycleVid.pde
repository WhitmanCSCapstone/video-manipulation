import processing.video.*;

Movie vid;
float ry = 0.0;

void setup(){
  size(1280,800,P3D);
  vid = new Movie(this, "ryd.mov");
  vid.loop();
  noStroke();
}

void draw(){
  translate(width / 2, height/2);
  if (vid.available() == true) {
    vid.read();
  }
  vid.speed(.5);
  if(mousePressed){
   float ma = map(mouseX, 0,width,0,65);
   float mb = map(mouseY, height,0,0,65);
   rotateY (ry);
  ry = ry + ma;
  rotateX (mb);}
   beginShape();
  // tint(255,120);
  texture(vid);
  vertex(-640, -400, 0, 0, 0);
  vertex(640, -400, 0, vid.width, 0);
  vertex(640, 400, 0, vid.width, vid.height);
  vertex(-640, 400, 0, 0, vid.height);
  endShape();
}
