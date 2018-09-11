import processing.video.*;
import processing.sound.*;


AudioIn mic;
Amplitude amp;


Movie movie;


float rotx = PI/4;
float roty = PI/4;

void setup() {
  size(1280, 800, P3D);
  
  movie = new Movie(this," Dec 30 2017 X Multiply.mov");
movie.loop();
mic = new AudioIn(this,0);
mic.start();
amp = new Amplitude(this);
amp.input(mic);
  textureMode(NORMAL);
  //fill(255);
  //stroke(color(44,48,32));
}

void movieEvent(Movie m) {
  m.read();
}

void draw() {
  float msize = map(amp.analyze(),0,.7,.9,2);
  background(255);
  
  noStroke();
  translate(width/2.0, height/2.0, -100);
 float r = map(amp.analyze(),.1,.7,0.0020,0.001 );
   rotateZ(frameCount * r);
  rotateX(frameCount * r);
  rotateY(frameCount * r);
  scale(190 * msize);
  TexturedCube(movie);
 
}

void TexturedCube(Movie movie) {
  //float mtint = map(amp.analyze(),0,.6,0,255);
  beginShape(QUADS);
  // tint(255,mtint);
  texture(movie);

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

void mouseMoved() {
  float rate = 0.01;
  rotx += (pmouseY-mouseY) * rate;
  roty += (mouseX-pmouseX) * rate;
}