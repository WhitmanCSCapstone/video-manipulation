//import processing.video.*;

//Movie vid;
float ry = 0.0;

void setup(){
  size(1280,800,P3D);

  //vid = new Movie(this, "uuu.mov");
  //vid.loop();
  //noStroke()
 strokeWeight(.01);
 rectMode(CENTER);
}

void draw(){
fill(255,5);
rect(width/2,height/2,width,height);
  //fill(0,10);
  //rect(0,0,0,width,height);
  translate(width / 2, height/2);
 // if (vid.available() == true) {
    //vid.read();
  //}
  if(mousePressed){
   float ma = map(mouseX, 0,width,0,.65);
   float mb = map(mouseY, height,0,0,.65);
   rotateY (ry);
  ry = ry + ma;
  rotateX (mb);}
    scale(220);
  TexturedCube();
}

void TexturedCube() {
  stroke(0,150);
  beginShape(QUADS);
 noFill();
  // Given one texture and six faces, we can easily set up the uv coordinates
  // such that four of the faces tile "perfectly" along either u or v, but the other
  // two faces cannot be so aligned.  This code tiles "along" u, "around" the X/Z faces
  // and fudges the Y faces - the Y faces are arbitrarily aligned such that a
  // rotation along the X axis will put the "top" of either texture at the "top"
  // of the screen, but is not otherwised aligned with the X/Z faces. (This
  // just affects what type of symmetry is required if you need seamless
  // tiling all the way around the cube)
  
  // +Z "front" face
  vertex(-1, -1,  1, 0, 0);
  vertex( 1, -1,  1, 1, 0);
  vertex( 1,  1,  1, 1, 1);
  vertex(-1,  1,  1, 0, 1);

  // -Z "back" face
  vertex( 1, -1, -1, 0, 0);
  vertex(-1, -1, -1, 1, 0);
  vertex(-1,  1, -1, 1, 1);
  vertex( 1,  1, -1, 0, 1);

  // +Y "bottom" face
  vertex(-1,  1,  1, 0, 0);
  vertex( 1,  1,  1, 1, 0);
  vertex( 1,  1, -1, 1, 1);
  vertex(-1,  1, -1, 0, 1);

  // -Y "top" face
  vertex(-1, -1, -1, 0, 0);
  vertex( 1, -1, -1, 1, 0);
  vertex( 1, -1,  1, 1, 1);
  vertex(-1, -1,  1, 0, 1);

  // +X "right" face
  vertex( 1, -1,  1, 0, 0);
  vertex( 1, -1, -1, 1, 0);
  vertex( 1,  1, -1, 1, 1);
  vertex( 1,  1,  1, 0, 1);

  // -X "left" face
  vertex(-1, -1, -1, 0, 0);
  vertex(-1, -1,  1, 1, 0);
  vertex(-1,  1,  1, 1, 1);
  vertex(-1,  1, -1, 0, 1);

  endShape();
}
