//import processing.video.*;

//Movie vid;
float ry = 0.0;

void setup(){
  size(1280,800,P3D);
  //vid = new Movie(this, "uuu.mov");
  //vid.loop();
  //noStroke()
 strokeWeight(2);
 fill(0);
 stroke(255);
 rectMode(CENTER);
}

void draw(){
  //fill(0,10);
  //rect(0,0,0,width,height);
  translate(width / 2, height/2);
 // if (vid.available() == true) {
    //vid.read();
  //}
  if(mousePressed){
   float ma = map(mouseX, 0,width,0,65);
   float mb = map(mouseY, height,0,0,65);
   rotateY (ry);
  ry = ry + ma;
  rotateX (mb);}
   beginShape();
  // tint(255,120);
  //texture(vid);
  rect(0,0,800,800);
  vertex(-640, -400, 0, 0, 0);
  vertex(640, -400, 0, width, 0);
  vertex(640, 400, 0, width, height);
  vertex(-640, 400, 0, 0, height);
  endShape();
}
