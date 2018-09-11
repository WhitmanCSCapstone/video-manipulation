PImage img;
float ry = 0.0;

void setup(){
  size(1280,800,P3D);
  img = loadImage("b.png");
}

void draw(){
  translate(width / 2, height/2);
  
  
   float ma = map(mouseX, 0,width,.002,.2);
   rotateY (ry);
  ry = ry + ma;
   beginShape();
  texture(img);
  vertex(-600, -400, 0, 0, 0);
  vertex(600, -400, 0, img.width, 0);
  vertex(600, 400, 0, img.width, img.height);
  vertex(-600, 400, 0, 0, img.height);
  endShape();
}
