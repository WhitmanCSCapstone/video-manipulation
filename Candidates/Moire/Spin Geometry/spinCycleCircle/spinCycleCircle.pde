PImage img;
float ry = 0.0;

void setup(){
  size(1280,800,P3D);
  img = loadImage("b.png");
  background(255);
  //strokeWeight(2);
hint(DISABLE_DEPTH_TEST);
//noStroke();
}

void draw(){
  float op = map(mouseY,height,0,0,255);
fill(255,op);
rect(0,0,width,height);
  translate(width / 2, height/2);
  
  
   float ma = map(mouseX, 0,width,.002,20);
   rotateY (ry);
  ry = ry + ma;
   beginShape();
  //texture(img);
 // vertex(-600, -400, 0, 0, 0);
  //vertex(600, -400, 0, img.width, 0);
  //vertex(600, 400, 0, img.width, img.height);
  //vertex(-600, 400, 0, 0, img.height);
  //fill(0,50);
  ellipse(0,0,height,height);
    //texture(img);
  endShape();
}
